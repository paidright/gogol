{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

-- |
-- Module      : Network.Google.Auth.ApplicationDefaultCredentials
-- Copyright   : (c) 2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)

module Network.Google.Auth.ApplicationDefaultCredentials where

import           Control.Applicative
import           Control.Concurrent
import           Control.Exception.Lens
import           Control.Lens                    hiding (coerce, (.=))
import           Control.Monad
import           Control.Monad.Catch
import           Control.Monad.IO.Class
import           Crypto.Hash.Algorithms          (SHA256 (..))
import           Crypto.PubKey.RSA.PKCS15        (signSafer)
import           Crypto.PubKey.RSA.Types         (PrivateKey)
import           Data.Aeson
import           Data.Aeson.Types
import           Data.ByteArray
import           Data.ByteArray.Encoding
import           Data.ByteString                 (ByteString)
import           Data.ByteString.Builder         (Builder)
import qualified Data.ByteString.Builder         as Build
import qualified Data.ByteString.Char8           as BS8
import qualified Data.ByteString.Lazy            as LBS
import           Data.Coerce
import           Data.Default.Class              (def)
import           Data.List                       (intersperse)
import           Data.String
import qualified Data.Text                       as Text
import qualified Data.Text.Encoding              as Text
import qualified Data.Text.Lazy                  as LText
import qualified Data.Text.Lazy.Builder          as TBuild
import qualified Data.Text.Lazy.Encoding         as LText
import           Data.Time
import           Data.Time.Clock.POSIX
import           Data.Typeable
import           Data.X509
import           Data.X509.Memory
import           Network.Google.Compute.Metadata
import           Network.Google.Internal.Auth
import           Network.Google.Internal.Logger
import           Network.Google.Prelude          hiding (buildText)
import           Network.HTTP.Conduit            hiding (Request)
import qualified Network.HTTP.Conduit            as Client
import           Network.HTTP.Types
import           System.Directory                (doesFileExist,
                                                  getHomeDirectory)
import           System.Environment              (lookupEnv)
import           System.FilePath                 ((</>))
import           System.Info                     (os)

-- | The environment variable name which is used to specify the directory
-- containing the @application_default_credentials.json@ generated by @gcloud init@.
cloudSDKConfigDir :: String
cloudSDKConfigDir = "CLOUDSDK_CONFIG"

-- | The environment variable pointing the file with local
-- Application Default Credentials.
defaultCredentialsFile :: String
defaultCredentialsFile = "GOOGLE_APPLICATION_CREDENTIALS"

{-| Authorized User credentials which are typically generated by the Cloud SDK
Tools such as @gcloud init@, of the following form:

@
{
  \"type\": \"authorized_user\",
  \"client_id\": \"32555940559.apps.googleusercontent.com\",
  \"client_secret\": \"Zms2qjJy2998hD4CTg2ejr2\",
  \"refresh_token\": \"1/B3gM1x35v.VtqffS1n5w-rSJ\"
}
@

The secret and refresh token are used to obtain a valid 'OAuthToken' from
'accountsURL' using grant_type @refresh_token@.
-}
data AuthorizedUser = AuthorizedUser
    { _userId      :: !ClientId
    , _userRefresh :: !RefreshToken
    , _userSecret  :: !Secret
    } deriving (Eq, Show)

instance FromJSON AuthorizedUser where
    parseJSON = withObject "authorized_user" $ \o -> AuthorizedUser
        <$> o .: "client_id"
        <*> o .: "refresh_token"
        <*> o .: "client_secret"

authorizedUserToken :: (MonadIO m, MonadCatch m)
                    => AuthorizedUser
                    -> Maybe RefreshToken
                    -> Logger
                    -> Manager
                    -> m OAuthToken
authorizedUserToken u r = refreshRequest $
    accountsRequest
        { Client.requestBody = textBody $
               "grant_type=refresh_token"
            <> "&client_id="     <> toText (_userId     u)
            <> "&client_secret=" <> toText (_userSecret u)
            <> "&refresh_token=" <> toText (fromMaybe (_userRefresh u) r)
        }

-- -- | Attempt to load either a @service_account@ or @authorized_user@ formatted
-- -- file to obtain the credentials neccessary to perform a token refresh.
-- --
-- -- The specified 'Scope's are used to authorize any @service_account@ that is
-- -- found with the appropriate scopes, otherwise they are not used. See the
-- -- top-level module of each individual @gogol-*@ library for a list of available
-- -- scopes, such as @Network.Google.Compute.computeScope@.
-- --
-- -- /See:/ 'cloudSDKConfigPath', 'defaultCredentialsPath'.
-- fromFile :: (MonadIO m, MonadCatch m) => [OAuthScope] -> m Credentials
-- fromFile ss = do
--     f <- defaultCredentialsPath
--     case f of
--         Just x  -> fromFilePath ss x
--         Nothing -> do
--             x <- cloudSDKConfigPath
--             fromFilePath ss x

-- -- | Attempt to load either a @service_account@ or @authorized_user@ formatted
-- -- file to obtain the credentials neccessary to perform a token refresh from
-- -- the specified file.
-- --
-- -- The specified 'Scope's are used to authorize any @service_account@ that is
-- -- found with the appropriate scopes, otherwise they are not used. See the
-- -- top-level module of each individual @gogol-*@ library for a list of available
-- -- scopes, such as @Network.Google.Compute.computeScope@.
-- fromFilePath :: (MonadIO m, MonadCatch m)
--              => [OAuthScope]
--              -> FilePath
--              -> m Credentials
-- fromFilePath ss f = do
--     p  <- liftIO (doesFileExist f)
--     unless p $
--         throwM (MissingFileError f)
--     bs <- liftIO (LBS.readFile f)
--     either (throwM . InvalidFileError f . Text.pack) pure
--            (fromJSONCredentials ss bs)

-- fromJSONCredentials :: [OAuthScope]
--                     -> LBS.ByteString
--                     -> Either String Credentials
-- fromJSONCredentials ss bs = do
--     v <- eitherDecode' bs
--     let x = (`FromAccount` ss) <$> parseEither parseJSON v
--         y = FromUser           <$> parseEither parseJSON v
--     case (x, y) of
--         (Left xe, Left ye) -> Left $
--               "Failed parsing service_account: " ++ xe ++
--             ", Failed parsing authorized_user: " ++ ye
--         _                  -> x <|> y

-- | Lookup the @GOOGLE_APPLICATION_CREDENTIALS@ environment variable for the
-- default application credentials filepath.
defaultCredentialsPath :: MonadIO m => m (Maybe FilePath)
defaultCredentialsPath = liftIO (lookupEnv defaultCredentialsFile)

-- | Return the filepath to the Cloud SDK well known file location such as
-- @~\/.config\/gcloud\/application_default_credentials.json@.
cloudSDKConfigPath :: MonadIO m => m FilePath
cloudSDKConfigPath = do
    m <- liftIO (lookupEnv cloudSDKConfigDir)
    case m of
        Just d  -> pure $! d </> "application_default_credentials.json"
        Nothing -> do
            d <- getConfigDirectory
            pure $! d </> "gcloud/application_default_credentials.json"

getConfigDirectory :: MonadIO m => m FilePath
getConfigDirectory = do
    h <- liftIO getHomeDirectory
    if os == "windows"
        then pure h
        else pure $! h </> ".config"

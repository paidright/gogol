module Kuy.Store.Manifest where

import Kuy.Store.Artefact
import Data.ByteString.Char8 qualified as ByteString.Char8
import Data.ByteString.Lazy qualified as ByteString.Lazy
import System.FilePath qualified as FilePath
import UnliftIO.Directory qualified as Directory
import Data.ByteString qualified as ByteString
import Data.ByteString.Builder qualified as ByteBuilder
import Data.Map.Strict qualified as Map
import UnliftIO qualified
import Kuy.Prelude
import Kuy.Store.Fingerprint
import Data.Either.Validation (Validation (..), validationToEither, eitherToValidation)

newtype Manifest = Manifest { hashes :: Map FilePath Fingerprint}
  deriving stock (Show)
  deriving newtype (Semigroup, Monoid)

encodeManifest :: Manifest -> ByteStringLazy
encodeManifest m =
  flip Map.foldMapWithKey m.hashes $ \k v ->
    ByteBuilder.toLazyByteString $
     ByteBuilder.byteString (encodeFingerprint v)
      <> "  "
      <> ByteBuilder.stringUtf8 k
      <> "\n"

decodeManifest :: [ByteString] -> Either [String] Manifest
decodeManifest =
  validationToEither
    . fmap (Manifest . Map.fromList)
    . traverse (bitraverse parseKey parseVal . ByteString.splitAt fingerprintSize)
    . filter (not . ByteString.null)
 where
   parseKey = Success . ByteString.Char8.unpack
   parseVal = eitherToValidation . first (:[]) . decodeFingerprint

isKnownArtefact :: Artefact -> Manifest -> Bool
isKnownArtefact x m = maybe False (x.hash ==) (Map.lookup x.path m.hashes)

insertArtefact :: Artefact -> Manifest -> Manifest
insertArtefact x m = m { hashes = Map.insert x.path x.hash m.hashes }

readManifest :: MonadIO m => FilePath -> m Manifest
readManifest path = do
  exists <- Directory.doesPathExist path
  bytes <-  liftIO (ByteString.readFile path)

  let result =
        if exists
          then decodeManifest (ByteString.Char8.lines bytes)
          else pure mempty

  case result of
    Right ok -> pure ok
    Left err ->
      UnliftIO.throwString $
        "(readManifest) failed parsing md5sums from  "
          ++ path
          ++ " with "
          ++ show err

writeManifest :: MonadIO m => FilePath -> Manifest -> m ()
writeManifest path manifest =
  Directory.createDirectoryIfMissing True (FilePath.takeDirectory path)
   *> liftIO (ByteString.Lazy.writeFile path (encodeManifest manifest))

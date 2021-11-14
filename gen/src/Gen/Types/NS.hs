-- | Module      : Gen.Types.NS
-- Copyright   : (c) 2015-2021 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : provisional
-- Portability : non-portable (GHC extensions)
module Gen.Types.NS
  ( NS,
    mkNS,
    unNS,
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Data.Text.Manipulate as Text.Manipulate
import Gen.Prelude
import Gen.Text

newtype NS = NS {unNS :: [Text]}
  deriving (Eq, Ord, Show)

mkNS :: Text -> NS
mkNS = NS . map (upperAcronym . upperHead) . Text.split (== '.')

instance IsString NS where
  fromString "" = mempty
  fromString s = mkNS (fromString s)

instance Monoid NS where
  mempty = NS []
  mappend (NS xs) (NS ys)
    | null xs = NS ys
    | null ys = NS xs
    | otherwise = NS (mappend xs ys)

instance Semigroup NS where
  (<>) = mappend

instance FromJSON NS where
  parseJSON = withText "namespace" (pure . mkNS)

instance ToJSON NS where
  toJSON (NS xs) = toJSON (Text.intercalate "." xs)

module Data.URI where

import Prelude

import Data.Argonaut (class DecodeJson)
import Data.Argonaut.Decode.Decoders (decodeString)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

newtype URI = URI String

mkURI :: String -> URI
mkURI = URI -- TODO: real parser

derive instance eqURI :: Eq URI

instance decodeJsonURI :: DecodeJson URI where
  decodeJson v = URI <$> decodeString v

derive instance genericURI :: Generic URI _

instance showURI :: Show URI where
  show = genericShow
module Data.Email where

import Prelude

import Data.Argonaut (class DecodeJson)
import Data.Argonaut.Decode.Decoders (decodeString)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

-- | Email address.
-- | TODO: real parser
newtype Email = Email String

derive instance eqEmail :: Eq Email

derive instance genericEmail :: Generic Email _

instance showEmail :: Show Email where
  show = genericShow

instance decodeJsonEmail :: DecodeJson Email where
  decodeJson json = Email <$> decodeString json

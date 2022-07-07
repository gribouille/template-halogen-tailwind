module Data.Avatar where

import Prelude
import Data.Argonaut (class DecodeJson)
import Data.Argonaut.Decode.Decoders (decodeString)

newtype Avatar = Avatar String

derive instance eqAvatar :: Eq Avatar

instance decodeJsonUserAvatar :: DecodeJson Avatar where
  decodeJson json = decodeString json >>= (pure <<< Avatar)
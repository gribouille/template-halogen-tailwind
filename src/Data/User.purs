module Data.User
  ( ID(..)
  , Mode(..)
  , User(..)
  ) where

import Prelude
import Data.Argonaut (class DecodeJson, decodeJson, (.:))
import Data.Argonaut.Decode.Decoders (decodeInt, decodeString)
import Data.Email (Email)
import Data.Avatar (Avatar)

newtype ID = ID Int

data Mode = Reader | Writer | Admin

newtype User = User
  { id :: ID
  , login :: String
  , email :: Email
  , avatar :: Avatar
  , mode :: Mode
  }

--
-- Decoders
--

derive instance eqID :: Eq ID
derive instance ordID :: Ord ID

instance decodeJsonUserID :: DecodeJson ID where
  decodeJson json = decodeInt json >>= (pure <<< ID)

instance decodeJsonUserMode :: DecodeJson Mode where
  decodeJson json = decodeString json <#>
    ( \r -> case r of
        "reader" -> Reader
        "writer" -> Writer
        "admin" -> Admin
        _ -> Reader
    )

instance decodeJsonUser :: DecodeJson User where
  decodeJson json = do
    x <- decodeJson json
    id <- x .: "id"
    login <- x .: "login"
    email <- x .: "email"
    avatar <- x .: "avatar"
    mode <- x .: "mode"
    pure $ User { id, login, email, avatar, mode }
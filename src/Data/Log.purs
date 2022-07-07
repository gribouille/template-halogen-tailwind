module Data.Log where

import Prelude

import Data.Argonaut (class DecodeJson)
import Data.Argonaut.Decode.Decoders (decodeString)
import Data.DateTime (DateTime)
import Data.Generic.Rep (class Generic)

data Level = Debug | Info | Warn | Error | Fatal

newtype Message = Message
  { message :: String
  , level :: Level
  , timestamp :: DateTime
  }

derive instance genericMessage :: Generic Message _

derive instance genericLevel :: Generic Level _

instance showLevel :: Show Level where
  show = case _ of
    Debug -> "debug"
    Info -> "info"
    Warn -> "warn"
    Error -> "error"
    Fatal -> "fatal"

instance decodeLevel :: DecodeJson Level where
  decodeJson json = decodeString json <#>
    ( case _ of
        "debug" -> Debug
        "info" -> Info
        "warn" -> Warn
        "error" -> Error
        "fatal" -> Fatal
        _ -> Info
    )
module Data.Flags where

import Prelude

import Data.Argonaut (class DecodeJson, decodeJson, (.:))
import Data.Email (Email)
import Data.Generic.Rep (class Generic)
import Data.Log (Level)
import Data.Show.Generic (genericShow)
import Data.URI (URI)

-- | Application input flags.
newtype Flags = Flags
  { info :: Info
  , env :: Env
  , version :: Version
  }

-- | Information set at compile-time.
newtype Info = Info
  { name :: String
  , title :: String
  , description :: String
  , contact :: Email
  , documentation :: URI
  }

-- | Build information set at compile-time.
newtype Version = Version
  { commit :: String
  , tag :: String
  , date :: String -- TODO: DateTime
  }

-- | Flags set at runtime.
newtype Env = Env
  { protocol :: String
  , hostname :: String
  , gateway :: URI
  , region :: String
  , logLevel :: Level
  }

derive instance genericFlags :: Generic Flags _

derive instance genericInfo :: Generic Info _

derive instance genericVersion :: Generic Version _

derive instance genericEnv :: Generic Env _

instance showFlags :: Show Flags where
  show = genericShow

instance showInfo :: Show Info where
  show = genericShow

instance showVersion :: Show Version where
  show = genericShow

instance showEnv :: Show Env where
  show = genericShow

instance decodeJsonFlags :: DecodeJson Flags where
  decodeJson x = do
    r <- decodeJson x
    i <- r .: "info"
    e <- r .: "env"
    v <- r .: "version"
    pure $ Flags { info: i, env: e, version: v }

instance decodeJsonInfo :: DecodeJson Info where
  decodeJson x = do
    r <- decodeJson x
    n <- r .: "name"
    t <- r .: "title"
    d <- r .: "description"
    c <- r .: "contact"
    e <- r .: "documentation"
    pure $ Info { name: n, title: t, description: d, contact: c, documentation: e }

instance decodeJsonVersion :: DecodeJson Version where
  decodeJson x = do
    r <- decodeJson x
    c <- r .: "commit"
    t <- r .: "tag"
    d <- r .: "date"
    pure $ Version { commit: c, tag: t, date: d }

instance decodeJsonEnv :: DecodeJson Env where
  decodeJson x = do
    y <- decodeJson x
    p <- y .: "protocol"
    h <- y .: "hostname"
    g <- y .: "gateway"
    r <- y .: "region"
    l <- y .: "log_level"
    pure $ Env { protocol: p, hostname: h, gateway: g, region: r, logLevel: l }

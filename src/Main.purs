module Main
  ( main
  ) where

import Prelude

import Affjax (Error)
import AppM (runAppM)
import Component.Router as Router
import Control.Monad.Error.Class (throwError)
import Data.Argonaut (Json, JsonDecodeError, decodeJson)
import Data.Either (Either, either)
import Data.Flags (Flags)
import Data.Item (ID, Item)
import Data.Maybe (Maybe(..))
import Data.User (User)
import Effect (Effect)
import Effect.Aff (error, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (logShow)
import Halogen (mkTell)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Route (route)
import Routing.Duplex (parse)
import Routing.Hash (matchesWith)
import Store as Store

main :: Json -> Effect Unit
main args = do
  flags <- invalidArgs $ (decodeJson args :: Either JsonDecodeError Flags)
  _ <- logShow flags

  HA.runHalogenAff do
    body <- HA.awaitBody
    root <- runAppM (Store.init flags) Router.component
    halo <- runUI root unit body

    -- send query (Navigate) to Router component
    void $ liftEffect $ matchesWith (parse route) \old new ->
      when (old /= Just new) $ launchAff_ do
        _res <- halo.query $ mkTell $ Router.Navigate new
        pure unit

class Monad m <= PublicResource m where
  getItems :: m (Either Error (Array Item))
  getItem :: ID -> m (Either Error Item)

class Monad m <= Authentification m where
  readCredentials :: m (Either Error (User))
  writeCredentials :: (User) -> m (Either Error (User))
  deleteCredentials :: m (Either Error Unit)

invalidArgs :: forall a. Either JsonDecodeError a -> Effect a
invalidArgs =
  either (throwError <<< error <<< show) pure

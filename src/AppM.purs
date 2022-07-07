module AppM where

import Prelude

import Capability.Navigate (class Navigate, navigate)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Halogen (Component, liftEffect)
import Halogen.Store.Monad (class MonadStore, StoreT, runStoreT, updateStore)
import Route (route)
import Route as Route
import Routing.Duplex (print)
import Routing.Hash (setHash)
import Safe.Coerce (coerce)
import Store (Action(..), Store, update)

newtype AppM a = AppM (StoreT Action Store Aff a)

runAppM :: forall q i o. Store -> Component q i o AppM -> Aff (Component q i o Aff)
runAppM store = runStoreT store update <<< coerce

derive newtype instance functorAppM :: Functor AppM --            map    : (a -> b) -> f a -> f b
derive newtype instance applyAppM :: Apply AppM --                apply  : f (a -> b) -> f a -> f b
derive newtype instance applicativeAppM :: Applicative AppM --    pure   : a -> f a
derive newtype instance bindAppM :: Bind AppM --                  bind   : m a -> (a -> m b) -> m b
derive newtype instance monadAppM :: Monad AppM --                applicative + bind
derive newtype instance monadEffectAppM :: MonadEffect AppM --    liftEffect: forall a. Effect a -> m a     Effect ~> m
derive newtype instance monadAffAppM :: MonadAff AppM --          liftAff : forall a. Aff a -> m a          Aff ~> m
derive newtype instance monadStore :: MonadStore Action Store AppM

instance navigateAppM :: Navigate AppM where
  navigate = liftEffect <<< setHash <<< print route
  logout = do
    updateStore Logout
    navigate Route.Home
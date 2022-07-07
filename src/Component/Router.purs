module Component.Router
  ( Action(..)
  , Query(..)
  , Slots
  , State
  , component
  , handleAction
  , handleQuery
  ) where

import Prelude

import Capability.Navigate (class Navigate, navigate)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen (Component, ComponentHTML, HalogenM, Slot, defaultEval, get, mkComponent, mkEval, modify_)
import Halogen.HTML (div_, slot_, text)
import Halogen.Store.Monad (class MonadStore)
import Page.Home as Home
import Page.Login as Login
import Page.Details as Details
import Page.Settings as Settings

import Route (Route(..))
import Store as Store
import Type.Proxy (Proxy(..))

data Query a =
  Navigate Route a

type State =
  { route :: Maybe Route
  }

data Action = Initialize

type Slots =
  ( home :: forall q. Slot q Void Unit
  , login :: forall q. Slot q Void Unit
  , details :: forall q. Slot q Void Unit
  , settings :: forall q. Slot q Void Unit
  )

component
  :: forall m
   . MonadAff m
  => MonadStore Store.Action Store.Store m
  => Navigate m
  => Component Query Unit Void m
component =
  mkComponent
    { initialState: \_ -> { route: Nothing }
    , render
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , handleQuery = handleQuery
        , initialize = Just Initialize
        }
    }

render :: forall m. State -> ComponentHTML Action Slots m
render { route } = case route of
  Just Home ->
    slot_ (Proxy :: _ "home") unit Home.component unit

  Just Login ->
    slot_ (Proxy :: _ "login") unit Login.component unit

  Just (Details id) ->
    slot_ (Proxy :: _ "details") unit Details.component unit

  Just Settings ->
    slot_ (Proxy :: _ "settings") unit Settings.component unit

  Nothing ->
    div_ [ text "Page not found" ]

handleQuery
  :: forall a m
   . MonadAff m
  => MonadStore Store.Action Store.Store m
  => Navigate m
  => Query a
  -> HalogenM State Action Slots Void m (Maybe a)
handleQuery = case _ of
  Navigate r a -> do
    { route } <- get
    when (route /= Just r) do
      modify_ _ { route = Just r }
    pure (Just a)

handleAction
  :: forall o m
   . MonadAff m
  => MonadStore Store.Action Store.Store m
  => Navigate m
  => Action
  -> HalogenM State Action Slots o m Unit
handleAction = case _ of
  Initialize -> navigate Home
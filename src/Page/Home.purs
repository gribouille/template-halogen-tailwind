module Page.Home where

import Prelude hiding (div)

import Component.Utils (cls)
import Halogen (Component, ComponentHTML, HalogenM, defaultEval, mkComponent, mkEval, modify_)
import Halogen.HTML (div, text, a)
import Halogen.HTML.Properties (href)

type State = {}

data Action = NoOp

init :: forall i. i -> State
init _ =
  {}

view :: forall cs m. State -> ComponentHTML Action cs m
view state =
  div [ cls "w-full h-full flex flex-col" ]
    [ text "Home"
    , a [ href "#/details/32" ] [ text "Go to Details" ]
    , a [ href "#/login" ] [ text "Go to Login" ]
    , a [ href "#/settings" ] [ text "Go to Settings" ]

    ]

update :: forall cs o m. Action -> HalogenM State Action cs o m Unit
update =
  case _ of
    NoOp -> modify_ \s -> {}

component :: forall q i o m. Component q i o m
component =
  mkComponent
    { initialState: init
    , render: view
    , eval: mkEval defaultEval { handleAction = update }
    }

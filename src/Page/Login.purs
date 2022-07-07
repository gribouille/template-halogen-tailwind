module Page.Login where

import Prelude hiding (div)
import Halogen (Component, ComponentHTML, HalogenM, defaultEval, mkComponent, mkEval, modify_)
import Halogen.HTML (div, text)
import Component.Utils (cls)

type State = {}

data Action = NoOp

init :: forall i. i -> State
init _ =
  {}

view :: forall cs m. State -> ComponentHTML Action cs m
view state =
  div [ cls "w-full h-full" ]
    [ text "Login"
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

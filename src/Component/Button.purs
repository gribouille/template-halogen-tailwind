module Component.Button where

import Prelude

import Halogen (Component, ComponentHTML, mkComponent, HalogenM, modify_, mkEval, defaultEval)
import Halogen.HTML (ClassName(..), div_, p, text, button, img, IProp)
import Halogen.HTML.Events (onClick)
import Halogen.HTML.Properties (class_, src)

cls :: forall i r. String -> IProp (class :: String | r) i
cls = class_ <<< ClassName

type State = { count :: Int }

data Action = Increment

component :: forall q i o m. Component q i o m
component =
  mkComponent
    { initialState: \_ -> { count: 0 }
    , render
    , eval: mkEval defaultEval { handleAction = handleAction }
    }

render :: forall cs m. State -> ComponentHTML Action cs m
render state =
  div_
    [ p [ cls "font-bold text-xl" ]
        [ text $ "You clicked " <> show state.count <> " times" ]
    , button
        [ onClick \_ -> Increment ]
        [ text "Click me" ]

    , img [ src "assets/favicon.png" ]
    ]

handleAction :: forall cs o m. Action → HalogenM State Action cs o m Unit
handleAction =
  case _ of
    Increment -> modify_ \st -> st { count = st.count + 1 }

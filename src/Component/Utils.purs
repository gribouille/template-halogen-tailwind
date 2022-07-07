module Component.Utils where

import Prelude
import Halogen.HTML (IProp, ClassName(..))
import Halogen.HTML.Properties (class_)

{-| Shortcut to define class property. -}
cls :: forall i r. String -> IProp (class :: String | r) i
cls = class_ <<< ClassName
module Main
  ( main
  ) where

import Prelude

import Component.Button as Button
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

type Flags =
  { gateway :: String
  , version :: String
  , commit :: String
  }

main :: Flags -> Effect Unit
main _ = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI Button.component unit body
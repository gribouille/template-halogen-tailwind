module Capability.Navigate where

import Prelude

import Halogen (HalogenM, lift)
import Route (Route)

class Monad m <= Navigate m where
  navigate :: Route -> m Unit
  logout :: m Unit

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots msg m) where
  navigate = lift <<< navigate
  logout = lift logout
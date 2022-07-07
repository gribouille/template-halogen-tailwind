module Capability.Log where

import Prelude

import Halogen (HalogenM, lift)
import Data.Log (Message)

class Monad m <= Log m where
  log :: Message -> m Unit

instance logHalogenM :: Log m => Log (HalogenM state action slots msg m) where
  log = lift <<< log
module Route where

import Prelude

import Data.Either (note)
import Data.Generic.Rep (class Generic)
import Data.Item (ID, toStringID, parseID)
import Routing.Duplex (RouteDuplex', as, root, segment)
import Routing.Duplex.Generic (noArgs, sum)
import Routing.Duplex.Generic.Syntax ((/))

data Route
  = Home
  | Login
  | Details ID
  | Settings

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

route :: RouteDuplex' Route
route = root $ sum
  { "Home": noArgs
  , "Login": "login" / noArgs
  , "Details": "items" / routeID segment
  , "Settings": "settings" / noArgs
  }

routeID :: RouteDuplex' String -> RouteDuplex' ID
routeID = as toStringID parseID

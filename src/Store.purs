module Store where

import Data.Flags (Flags)
import Data.Maybe (Maybe(..))
import Data.User (User)

type Store =
  { flags :: Flags
  , user :: Maybe User
  }

data Action = Login User | Logout

init :: Flags -> Store
init f =
  { flags: f, user: Nothing }

update :: Store -> Action -> Store
update s = case _ of
  Login u -> s { user = Just u }
  Logout -> s { user = Nothing }

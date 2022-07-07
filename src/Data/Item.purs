module Data.Item where

import Prelude

import Data.Either (Either(..))
import Data.Int (decimal, fromString, toStringAs)
import Data.Maybe (Maybe(..))

-- import Unsafe.Coerce (unsafeCoerce)

newtype ID = ID Int

derive instance itemIDEq :: Eq ID
derive instance itemIDOrd :: Ord ID

toStringID :: ID -> String
toStringID (ID i) =
  toStringAs decimal i

parseID :: String -> Either String ID
parseID x =
  case fromString x of
    Nothing -> Left $ "invalid id: " <> x
    Just v -> Right $ ID v

type Item =
  { id :: ID
  , name :: String
  , createdAt :: String
  , updatedAt :: String
  }

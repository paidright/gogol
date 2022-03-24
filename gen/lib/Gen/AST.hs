module Gen.AST where

import Control.Lens (view)
import Control.Monad.Except qualified as Except
import Control.Monad.State.Strict qualified as State
import Data.Map.Strict qualified as Map
import Data.Set qualified as Set
import Gen.AST.Flatten (flatten)
import Gen.AST.Render (render)
import Gen.AST.Solve (solve)
import Gen.Prelude
import Gen.Types

runAST :: Version -> Service (Fix Schema) -> Either Text Library
runAST version service =
  State.evalState (Except.runExceptT go) (initial service)
  where
    go = do
      globalised <- flatten service
      (api, datatypes) <- render =<< solve globalised

      pure (Library version globalised api datatypes)

initial :: Service (Fix Schema) -> Memo
initial service =
  Memo service mempty mempty index core mempty
  where
    -- Top-level schema definitions with ids.
    index =
      Set.fromList
        . mapMaybe (view iId)
        . Map.elems
        $ service ^. dSchemas

    -- Types available in Gogol.Prelude.
    core =
      Map.fromList
        [ ("GBody", SLit requiredInfo RqBody),
          ("Stream", SLit requiredInfo RsBody),
          ("JsonValue", SLit requiredInfo JSONValue),
          ("JSONValue", SLit requiredInfo JSONValue)
        ]

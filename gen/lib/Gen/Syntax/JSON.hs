module Gen.Syntax.JSON where

import Control.Lens (view, (^.))
import qualified Control.Monad as Monad
import Data.Either
import qualified Data.Foldable as Foldable
import qualified Data.List as List
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as Text
import Gen.Syntax.Build
import Gen.Syntax.Record
import Gen.Types
import Language.Haskell.Exts

jsonInstances :: Global -> Map Local Solved -> [Decl ()]
jsonInstances g (Map.toList -> rs) = [decodeJSON, encodeJSON]
  where
    decodeJSON =
      instDecl (iRule (iCon "Core.FromJSON" `iApp` tyCon (dname g))) $
        Just
          [ iDecl . patBind (pvar "parseJSON") $
              app (app (var "Core.withObject") (dstr g)) $
                lamE [pvar "o"] $
                  ctorE g (map decode rs)
          ]

    decode (l, s)
      | _additional s = app (var "Core.parseJSONObject") (var "o")
      | Just x <- defaultE s = defJS l x
      | required s = reqJS l
      | monoid s = defJS l (var "Core.mempty")
      | otherwise = optJS l

    encodeJSON =
      case rs of
        [(k, v)]
          | _additional v ->
            encodeInst
              [ iWildcard "toJSON" g head defaultObject [var "Core.toJSON" `app` var (fname k)]
              ]
        --
        _other ->
          encodeInst
            [ iWildcard "toJSON" g omitNulls defaultObject (map encode rs)
            ]

    encodeInst =
      instDecl (iRule (iCon "Core.ToJSON" `iApp` tyCon (dname g)))
        . Just

    omitNulls = app (var "Core.object") . app (var "Core.catMaybes") . listE

    defaultObject = var "Core.mempty"

    encode (l, s)
      | text && optional =
        infixApp (infixApp (paren (app n o)) "Core.." (var "Core.AsText")) "Core.<$>" a
      | optional =
        infixApp (paren (app n o)) "Core.<$>" a
      | text =
        var "Core.Just" `app` infixApp n ".=" (var "Core.AsText" `app` a)
      | otherwise =
        var "Core.Just" `app` infixApp n "Core..=" a
      where
        n = localE l
        o = var "Core..="
        a = var (fname l)

        text = textual (_type s)

        optional =
          case _type s of
            TMaybe {} -> True
            _other -> False

iWildcard ::
  String ->
  Global ->
  ([Exp ()] -> Exp ()) ->
  Exp () ->
  [Exp ()] ->
  InstDecl ()
iWildcard f n encode def = \case
  [] -> iConst f def
  xs -> iDecl (funBind (name f) [pRecord (dname n) True] (unguardedRhs (encode xs)))

iConst :: String -> Exp () -> InstDecl ()
iConst f x = iDecl (sfun (name f) [] (unguardedRhs (var "Core.const" `app` x)) noBinds)

defJS :: Local -> Exp () -> Exp ()
defJS n = infixApp (infixApp (var "o") "Core..:?" (localE n)) "Core..!="

reqJS :: Local -> Exp ()
reqJS = infixApp (var "o") "Core..:" . localE

optJS :: Local -> Exp ()
optJS = infixApp (var "o") "Core..:?" . localE

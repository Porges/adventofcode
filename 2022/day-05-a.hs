{-# LANGUAGE ViewPatterns #-}
import Data.List (transpose)
import Data.Char (isAlpha)
import Control.Arrow ((>>>))
import qualified Data.Map as Map
import Data.Map (Map, (!))

type Stacks = Map.Map Int String

readDiagram :: [String] -> Stacks
readDiagram =
    transpose
    >>> map (filter isAlpha)
    >>> filter (not . null)
    >>> zip [1..]
    >>> Map.fromList

instruction :: Stacks -> String -> Stacks
instruction stacks (words -> ["move", read -> n, "from", read -> x, "to", read -> y]) =
    Map.insert x newX (Map.insert y newY stacks)
    where
    (toPush, newX) = splitAt n (stacks ! x)
    newY = reverse toPush ++ stacks ! y

main :: IO ()
main = do
    (readDiagram -> stacks, tail -> instructions) <- break null . lines <$> getContents
    let result = foldl instruction stacks instructions
    putStrLn (head <$> Map.elems result)

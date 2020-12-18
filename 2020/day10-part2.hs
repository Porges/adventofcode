{-# LANGUAGE ViewPatterns #-}
import Data.List (sort)
import Data.Map (Map, (!))
import qualified Data.Map as Map

main :: IO ()
main = do
  ns <- (fmap read . lines) <$> readFile "day10.txt"
  print (count ns)

count :: [Int] -> Int
count (sort -> xs) = go_memo ! 0
  where 
  go_memo :: Map Int Int
  go_memo = Map.fromList ((\x -> (x, go x)) <$> 0:xs)

  go :: Int -> Int
  go n =
    case dropWhile (<= n) (takeWhile (<= n+3) xs) of
      [] -> 1 -- got to end successfully
      ns -> sum ((go_memo !) <$> ns)

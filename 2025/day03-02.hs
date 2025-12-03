import Data.Char (digitToInt)
import Data.List (sortBy, tails, uncons)
import Data.Maybe (mapMaybe)
import Data.Ord (comparing)

-- Pairs of batteries & remaining batteries in descending jolts
batts :: [Int] -> [(Int, [Int])]
batts = sortBy (flip (comparing fst)) . mapMaybe uncons . tails

joltage :: Int -> [Int] -> Int
joltage n xs = head (go n xs 0)
    where
    go 0 _ acc = pure acc
    go n xs acc = do
        (x, xs) <- batts xs
        go (n-1) xs (acc*10 + x)

main = do
    ls <- lines <$> getContents
    let cases = map (map digitToInt) ls
    print (sum (map (joltage 12) cases))

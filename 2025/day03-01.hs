import Data.Char (digitToInt)
import Data.List (sortBy, tails, uncons)
import Data.Maybe (mapMaybe)
import Data.Ord (comparing)

-- Pairs of batteries & remaining batteries in descending jolts
batts :: [Int] -> [(Int, [Int])]
batts = sortBy (flip (comparing fst)) . mapMaybe uncons . tails

joltage :: [Int] -> Int
joltage xs = head $ do
    (n1, xs) <- batts xs
    (n2, __) <- batts xs
    pure (n1*10 + n2)

main = do
    ls <- lines <$> getContents
    let cases = map (map digitToInt) ls
    print (sum (map joltage cases))

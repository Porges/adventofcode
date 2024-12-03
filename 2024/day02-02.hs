isValid :: [Int] -> Bool
isValid levels = safe levels || safe (reverse levels) 
    where
    safe = all (\x -> x >= 1 && x <= 3) . deltas
    deltas l = zipWith (-) l (tail l)

drop1 :: [a] -> [[a]]
drop1 [] = []
drop1 (x:xs) = xs : map (x:) (drop1 xs)

main = do
    reports <- map (map read) . map words . lines <$> getContents
    let validReports = filter (any isValid . drop1) reports
    print (length validReports)

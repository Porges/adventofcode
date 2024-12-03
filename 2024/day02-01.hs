isValid :: [Int] -> Bool
isValid levels = safe levels || safe (reverse levels) 
    where
    safe = all (\x -> x >= 1 && x <= 3) . deltas
    deltas l = zipWith (-) l (tail l)

main = do
    reports <- map (map read) . map words . lines <$> getContents
    let validReports = filter isValid reports
    print (length validReports)

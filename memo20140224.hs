-- --------------------
--  Chapter 2
--  Believe the type
--  P.23 - P.34
-- --------------------

-- 型を調べる

-- :t 'a'

-- リスト内包表記の型宣言

moveNonUppercase :: [Char] -> [Char]
moveNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

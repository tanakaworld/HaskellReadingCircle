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


-- 一般的なHaskellの型

-- Integer
factorial :: Integer -> Integer
factorial n = product [1..n]

-- Float
circumference :: Float -> Float
circumference r = 2 * pi * r

-- Double
circumference' :: Double -> Double
circumference' r = 2 * pi * r



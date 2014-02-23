-- --------------------
--  Chapter 2
--  Believe the type
--  P.23 - P.34
-- --------------------

-- --------------------
-- 2.1 明示的な型宣言
-- --------------------

-- 型を調べる

-- > :t 'a'
-- > 'a' :: Char


-- リスト内包表記の型宣言

moveNonUppercase :: [Char] -> [Char]
moveNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z


-- --------------------
-- 2.2 一般的なHaskellの型
-- --------------------

-- Integer
factorial :: Integer -> Integer
factorial n = product [1..n]

-- Float
circumference :: Float -> Float
circumference r = 2 * pi * r

-- Double
circumference' :: Double -> Double
circumference' r = 2 * pi * r


-- --------------------
-- 2.3 型変数
-- --------------------

-- > :t head
-- > head :: [a] -> a
{-
	型変数：どんな型でも取り得る
	型変数を用いた関数：多相的関数
	
	head i.e.
	「任意の型のリストに対して、その型の要素を一つ返す」
-}

-- > :t fst
-- > fst :: (a, b) -> a
{- 
	fst i.e.
	「タプルを引数に取り、その一つ目と同じ型の値を返す」
-}
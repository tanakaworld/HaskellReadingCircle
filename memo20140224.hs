-- --------------------
--  Chapter 2
--  Believe the type
--  P.23 - P.34
-- --------------------

-- ※Ⅰ このファイルに記述してある関数を読み込むために、GHCIコマンドは「-- >」でコメントアウトしてあります。
-- ※Ⅱ 「-- >」と書いてあるものは、ghci上で動きます。


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


-- --------------------
-- 2.4 型クラス初級講座
-- --------------------


-- Eq型クラス (等値性をテストできる型)

-- > :t (==)
-- > (==) :: Eq a => a -> a -> Bool
{-
	(==) i.e.
	「等値性関数は、同じ型の任意の二つの引数を取り、Boolを返す。」
	「引数の二つの値の型は、Eqクラスのインスタンスで無ければならない」
-}

-- > 5 == 5
-- > 5 /= 5
-- > 'a' == 'a'
-- > "Ho Ho" == "Ho Ho"\
-- > 3.456 == 3.456


-- Ord型クラス（何らかの順序を付けられる型）

-- > :t (>)
-- > (>) :: Ord a => a -> a -> Bool

-- > "Hogehogehoge" < "Hugahuga"
-- > "Hogehogehoge" `compare` "Hugahuga"
-- > 5 >= 2
-- > 5 `compare` 2

{-
	LT Less Than
	GT Greater Than
	EQ EQual to
-}


-- Show型クラス（ある値を文字列として表現）

-- > Prelude> :t (show)
-- > (show) :: Show a => a -> String

-- > show 3
-- > show 5.334
-- > show True


-- Read型クラス（Showの対となるクラス。文字列をRead型のインスタンス値を返す）

-- > :t (read)
-- > (read) :: Read a => String -> a

-- > read "True" || False
-- > read "8.2" + 3.8
-- > read "5" - 2
-- > read "[1,2,3,4]" ++ [3]
-- > read "4"


-- 型注釈
-- > read "4" :: Int
-- > read "4" :: Float
-- > (read "4" :: Float) * 4
-- > read "[1,2,3,4]" :: [Int]
-- > read "(3, 'a')" :: (Int, Char)

{-
	静的型付け言語なので、コードをコンパイルする前に、全ての型がわかってる必要がある
-}

-- > [read "True", False]
-- > [read "True", False, True, False]
-- > (read "True", False, True, False)


-- Enum型クラス（要素の値を列挙できる型）
-- > ['a' .. 'e']
-- > [LT .. GT]
-- > [3 .. 5]
-- > succ 'B'
-- > pred 'B'


-- Bounded型クラス

-- > :t minBound
-- > minBound :: Bounded a => a

-- > minBound :: Int
-- > maxBound :: Char
-- > maxBound :: Bool
-- > minBound :: Bool

-- > maxBound :: (Bool, Int, Char)


-- Num型クラス
-- > :t 20
-- > 20 :: Num a => a

-- > 20 :: Int
-- > 20 :: Intger
-- > 20 :: Float
-- > 20 :: Double


-- > :t (*)
-- > (*) :: Num a => a -> a -> a

{-
	「*」が二つの数を受け取り、一つの数を返す
	これら三つの数はすべて同じ型である
-}


-- > (5 :: Int) * (6 :: Integer)
-- > 5 * (6 :: Integer)


-- Floating型クラス

-- > :t sin
-- > sin :: Floating a => a -> a
-- > :t cos
-- > cos :: Floating a => a -> a
-- > :t sqrt
-- > sqrt :: Floating a => a -> a


-- Integral型クラス

-- > :t fromIntegral
-- > fromIntegral :: (Integral a, Num b) => a -> b

{-
	Num : 実数を含む全ての数を含む
	Integral : 整数（全体）のみ含む
-}

-- > fromIntegral (length [1,2,3,4]) + 3.2

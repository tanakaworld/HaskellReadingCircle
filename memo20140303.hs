{-# OPTIONS -Wall #-}
-- 警告を出してくれるオプション

-- ※Ⅰ このファイルに記述してある関数を読み込むために、GHCIコマンドは「-- >」でコメントアウトしてあります。
-- ※Ⅱ 「-- >」と書いてあるものは、ghci上で動きます。



-- ------------------------------
-- 3 関数の構文 (P.35 - P.49)
-- ------------------------------
-- Haskellの関数を書くための構文を見ていく。
-- 読み易く、理にかなった記法



-- ------------------------------
-- 3.1 パターンマッチ (P.35 - P.40)
-- ------------------------------
-- 関数を定義する際に使用し、関数の本体を場合分けする
--  これによってシンプルで読み易いコードが書ける

-- 渡された数が7かどうか調べる
lucky :: Int -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

-- 1から5が入力されたら英単語を出力
sayMe :: Int -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

-- 階乗を再帰的に定義
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- パターンマッチは失敗することもある
-- 例として次のような関数を定義することができる
charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"
-- 上記関数は予期せぬ値が入力されるとエラー
-- > charName 'a'
-- > charName 'b'
-- > charName 'h'
-- パターンを作るときは、全てに合致するパターンを最後に入れるべき



-- タプルのパターンマッチ

-- ベクトルの足し算
-- パターンマッチを知らない場合の書き方
addVectors' :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors' a b = (fst a + fst b, snd a + snd b)
-- パターンマッチを使用した定義
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
-- 型も変わらない
-- > :t addVectors'
-- > :t addVectors

-- トリプルの各要素を取り出す関数を定義
first :: (a, b, c) -> a
first (x, _, _) = x
second :: (a, b, c) -> b
second (_, y, _) = y
third :: (a, b, c) -> c
third (_, _, z) = z



-- リストのパターンマッチとリスト内包表記

-- リスト内包表記でもパターンマッチが使える
-- > let xs = [(1,3),(4,3),(2,4),(5,3),(5,6),(3,1)]
-- > [a+b | (a, b) <- xs]

-- リスト内包表記のパターンマッチは、失敗したら次に進み、失敗したものは結果に含まれない
-- > [x*100+3 | (x, 3) <- xs]

-- 普通のリストのパターンマッチ
-- x:xs というパターンは、リストのheadがx、リストのtailがxsに一致するという意味
-- headの実装
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x
-- > head' [4,5,6]
-- > head' "Hello"
-- 複数の変数に束縛したいときは丸括弧で囲まないとシンタックスエラー
-- errorは文字列を受け取りランタイムエラーを生成する関数

-- リストの要素を回りくどくて不便な書式で出力する
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y
-- > tell [1]
-- > tell [True, False]
-- > tell [1,2,3,4]
-- > tell []

-- 3要素のリストしか扱えない関数
badAdd :: (Num a) => [a] -> a
badAdd (x:y:z:[]) = x + y + z
-- > badAdd [100,20]

-- リストのパターンマッチでは++は使えない
-- (例) xs ++ ys はNG



-- asパターン
-- 値をパターンに分解しつつ、値自体も参照したいときに使う
-- (例) xs@(x:y:ys)
firstLetter :: String -> String
firstLetter "" = "Empty string, whoops!"
firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]
-- > firstLetter "Dracula"



-- ------------------------------
-- 3.2 場合分けして、きっちりガード！ (P.41 - P.43)
-- ------------------------------
-- 引数の構造で場合分けする場合はパターンを使う
-- 引数の値が満たす性質で場合分けする場合はガードを使う
-- 複数条件がある時はifより可読性が高く、パターンマッチとの相性も抜群

-- ガード
-- BMIによって叱る関数を定義
bmiTell :: Double -> String
bmiTell bmi
	| bmi <= 18.5 = "You're underweight, you emo, you!"
	| bmi <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
-- > bmiTell 24.3

-- 複数引数版
bmiTell' :: Double -> Double -> String
bmiTell' weight height
	| weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
	| weight / height ^ 2 <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
-- > bmiTell' 85 1.90

-- ありがちなミス: 引数とガードの間に = を入れてしまう

-- max関数
max' :: (Ord a) => a -> a -> a
max' a b
	| a <= b    = b
	| otherwise = a
-- > max' 3 2

-- compare関数
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
	| a == b    = EQ
	| a <= b    = LT
	| otherwise = GT
-- > 3 `myCompare` 2



-- ------
-- おまけ
-- ------
-- 自作last関数(Vatscy作)
last' :: [a] -> a
last' [] = error "Can't call last on an empty list, dummy!"
last' (x:[]) = x
last' (_:xs) = last' xs
-- > last' [1,2,3,4,5]

last'' :: [a] -> a
last'' xs = head' (reverse xs)
-- > last'' [1,2,3,4,5]

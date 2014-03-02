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

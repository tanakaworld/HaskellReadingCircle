-- --------------
-- リスト内包表記
-- --------------

[x*2 | x <- [1..10]]
-- 等比級数が書ける

-- xに"束縛"している

-- 条件 -> 述語 -> フィルタする
[x * 2 | x <- [1..10], x * 2 >= 12]
[x | x <- [50..100], x `mod` 7 == 3]

-- if式を混ぜる
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
boomBangs [7..13]

-- 述語をたくさん
[x | x <- [10..20], x /= 13, x /= 15, x/=19]

-- 複数のリスト
[x + y | x <- [1..3], y <- [10, 100, 1000]]
-- ↑とりだされる順番に注意

length' xs = sum [1 | _ <- xs]
-- _はつかいすて

length' [1, 2, 3]

removeNonUppercase st = [c | c <- st, c `elem` ['A'..'Z']]
removeNonUppercase "Kanda Taiki"


-- ------
-- タプル
-- ------

-- タプルは
-- 異なる型をいっしょに
-- 長さが固定(長さが変数に含まれる)
(1, 3)
('a', "ab", 1)

-- タプルは長さが違うと"別"
-- ダブルとトリプルは違う
-- →同じリストの中に入れることができない
[(1, 2), (8, 11, 5), (4, 5)] -- エラー

-- 違う型を含むタプルも違うもの
[(1, 2), ("One", 2)] -- エラー

-- リストみたいに要素を付け加えられない

-- 長さの同じタプルならば比較できる

-- ペアの関数がある
fst (8, 10)
snd (8, 10)

-- zip (大事!!!)
-- ペアのリストを作る
zip [1..5] ['a'..]

-- 直角三角形をみつける

-- 条件
-- 1. 3辺はすべて整数
-- 2. 各辺は10以下
-- 3. 3辺の合計は24に等しい

-- 2.の条件
triples = [(a, b, c) | a <- [1..10], b <- [1..10], c <- [1..10]]
print triples

-- 直角三角形である条件
rigthTriangles = [(a, b, c) | a <- [1..10], b <- [1..a], c <- [1..b], a^2 == b^2 + c^2]
print rigthTriangles

-- 3. の条件
rigthTriangles' = [(a, b, c) | a <- [1..10], b <- [1..a], c <- [1..b], a^2 == b^2 + c^2, a + b + c == 24]
print rigthTriangles'

-- -----------
-- 型を信じろ!
-- -----------

-- :tで型を確認できる
:t 'a'
:t "abc"

-- 明示的な型宣言ができる

removeNonUppercase' :: [Char] -> [Char]
removeNonUppercase' st = [c | c <- st, c `elem` ['A'..'Z']]

removeNonUppercase' "Kanda Taiki"

-- 型変数

-- a, b, cなどの適当な文字
:t head
:t fst
:t snd

-- 型クラス→関数の分類?
-- インスタンス→関数の実際?

:t (==)
-- Eqの型制約は
-- - 2つの引数
-- - Boolを返す
-- -引数はEqクラスのインスタンス

-- Ord 比較
-- Show 文字列として表わせる
-- Read Showの対

-- 型注釈
-- :: Xxx で型推論を補助
read "5" :: Int
read "5" :: Float

-- Enum 順序のあるもの
-- Bounded 上限下限を持つ
-- Num 数
-- Floating
-- Integral
>>>>>>> kanda

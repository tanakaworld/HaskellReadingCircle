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


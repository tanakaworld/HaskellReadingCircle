-- ------------------
-- 4.3 クイックソート！
-- ------------------

-- クイックソートの（基本）アルゴリズム
-- 1. 適当な数（ピボット）を選ぶ
-- 2. ピボットより小さい数を前方、大きい数を後方に移動する
-- 3. ピポッドで分割されたデータが空になるまで1から繰り返す
-- 
-- 5 1 9 4 6 7 3
-- "5" 1 9 4 6 7 3
-- 1 4 3 "5" 9 6 7
-- "1" 4 3 | 5 | "9" 6 7
-- _ "1" 4 3 | 5 | 6 7 "9" _
-- 1 | "4" 3 | 5 | "6" 7 | 9
-- 1 | 3 "4" _ | 5 | _ "6" 7 | 9
-- 1 | 3 | 4 | 5 | 6 | 7 | 9
-- 1 | _ "3" _ | 4 | 5 | 6 | _ "7" _ | 9
-- 1 | 3 | 4 | 5 | 6 | 7 | 9
-- 
-- ※ 計算時間 O(n logn) < O(n logn) < O(n^2)
-- ※ ピボットは本来ランダムに選ぶべきもの

--
-- コード
--

:set +m

let {
	quicksort :: (Ord a) => [a] -> [a];
	quicksort [] = [];
	quicksort (x:xs) = 
		let smallerOrEqual = [ a | a <- xs, a <= x ];
			larger = [ a | a <- xs, a > x];
		in quicksort smallerOrEqual ++ [x] ++ quicksort larger;
}

quicksort [5, 1, 9, 4, 6, 7, 3]
quicksort [10, 2, 5, 3, 1, 6, 7, 4, 2, 3, 4, 8, 9]
quicksort "the quick brown fox jumps over the lazy dog"

-- ------------------
-- 4.4 再帰的に考える
-- ------------------

-- 再帰を書く定跡
-- 1. 自明な解を持つ基底部を見つける
-- 2. 問題を部分問題に分割する
-- 3. 最終的な解を部分問題の解から構築する

--
-- ハノイの塔
-- 

-- 積み上げられた円盤をすべて他の棒に移す
-- 1回に移せる円盤は1枚のみ
-- 小さな円盤の上にそれより大きな円盤を乗せてはいけない
-- 棒以外のところに円盤を置いてはいけない

-- n = 3
--          |              |              |
--        ##|##            |              |
--      ####|####          |              |
--    ######|######        |              |
-- --------------------------------------------------
-- 
--          |              |              |
--          |              |            ##|##
--          |              |          ####|####
--          |              |        ######|######
-- --------------------------------------------------

-- 移動回数 (2^n) - 1

let {
	hanoi :: String -> String -> String -> Int -> [(String, String)];
	hanoi _ _ _ 0 = [];
	hanoi a b c n =
		hanoi a c b (n - 1) ++ [(a, b)] ++ hanoi c b a (n - 1);
}

hanoi "A" "B" "C" 3

-- ==============
--  第5章 高階関数
-- ==============

-- 関数の引数に関数を持てるもの
-- 関数の返り値として関数を返せるもの

-- -----------------
-- 5.1 カリー化関数
-- -----------------

-- Haskell Brooks Curry
-- 複数の引数を取る関数の代わりに、
-- 引数を1つだけ取る関数の組合せにしたものをカリー化関数という

-- Haskellの関数は、引数を1つだけ取るようになっている
-- 複数の引数を取っているように見えるのは、カリー化関数になっているから
max 4 5
(max 4) 5
-- (max 4)という関数が 引数に5を取っている

:t max
-- max :: Ord a => a -> a -> a
-- 等価
-- max :: Ord a => a -> (a -> a)

-- 3引数の関数
let {
	multThree :: Int -> Int -> Int -> Int;
	multThree x y z = x * y * z;
}

multThree 3 5 9
((multThree 3) 5) 9

-- 等価
let {
	multThree :: Int -> (Int -> (Int -> Int));
	multThree x y z = x * y * z;
}

let {
	multTwoWithNine :: Int -> Int -> Int;
	multTwoWithNine = multThree 9;
}
multTwoWithNine 2 3

-- Intを引数に取って100と比較する関数
let {
	compareWithHundred :: Int -> Ordering;
	compareWithHundred x = compare 100 x;
}
compareWithHundred 99

-- 等価
let {
	compareWithHundred :: Int -> Ordering;
	compareWithHundred = compare 100;
}

:t compare
-- compare :: Ord a => a -> a -> Ordering

-- 
-- セクション（という名のセクション）
--

-- 中置換数に対して部分適応をする

let {
	devideByTen :: (Floating a) => a -> a;
	devideByTen = (/10);
}
devideByTen 200
200 / 10
(/10) 200

let {
	isUpperAlphanum :: Char -> Bool;
	isUpperAlphanum = (`elem` ['A'..'Z']);
}
isUpperAlphanum 'L'
isUpperAlphanum 's'

-- '-' （負の数、マイナス）演算子に注意
let {
	subFour :: Int -> Int;
	subFour = (-4);
} -- エラー

let {
	subFour :: Int -> Int;
	subFour = (subtract 4);
}
subFour 10


--
-- 関数を表示する
-- 

multThree 42  -- 関数が返る

-- 第４章 Hello再帰!
--------------------

-- フィボナッチ数列って再帰使って定義できるよね?
-- F(n) = F(n - 1) + F(n - 2) (n = 2, 3, 4…)
-- where F(0) = 0, F(1) = 1
-- F(3) = F(2) + F(1)
--      = (F(1) + F(0)) + F(1)

--------------
-- 最高に最高!
--------------

--ギアをR(recursion)に

--maximum関数を新たに定義

:set +m

let {
	maximum' :: (Ord a) => [a] -> a;
	maximum' [] = error "Empty list!";
	maximum' [x] = x;
	maximum' (x:xs) = max x (maximum' xs);
}
--ひとつの要素からなるリストは中身を返す
--要素ひとつのリストになるまで再帰をくりかえす

maximum' [1, 2, 3]
maximum' [1..100]
maximum' [1..1000]

--------------------------
--さらにいくつかの再帰関数
--------------------------

--replicate
--Intをくりかえしたリストを返す
replicate 2 5

let {
	replicate' :: Int => a -> [a];
	replicate' n x
		|n <= 0 = []
		|otherwise = x:(replicate' (n - 1) x)
}

replicate' 2 5

--take
--指定された数リストからぬきとる
take 3 [1..5]

let {
	take' :: (Num i, Ord i) => i -> [a] -> [a];
	take' n _
		| n <= 0 = [];
	take' _ [] = [];
	take' n (x:xs) = x:take' (n - 1) xs
}

take' 3 [1..5]

--maximum'とreplicate', take'に注目すると…
--再帰といいながらくりかえしの状態をあらわす変数を持っている!!!

--reverse
let {
	reverse' :: [a] -> [a];
	reverse' [] = [];
	reverse' (x:xs) = reverse' xs ++ [x]; --xをリストにしてくっつける
}

reverse' [1..5]

--zip
--ダブルのリストを作る
zip [1..5] [11..15]

let {
	zip' :: [a] -> [b] -> [(a, b)];
	zip' _ [] = [];
	zip' [] _ = [];
	zip' (x:xs) (y:ys) = (x, y):zip' xs ys;
}

zip' [1..5] [11..15]
zip' [1..3] ['a'..'e']

--elem

elem 1 [1..5]
elem 10 [1..5]

let {
	elem' :: (Eq a) => a -> [a] -> Bool;
	elem' a [] = False;
	elem' a (x:xs)
		|a == x = True
		|otherwise = elem a xs;  
}

elem' 'a' ['a'..'e']
elem' 1000 [1..100]

--------
--おまけ
--------

--階乗いろいろ

--定番
let {
	factorial :: Int -> Int;
	factorial 0 = 1;
	factorial i = i * factorial (i - 1);
}
factorial 3

--schemeっぽく
fac n = (if ((==) n 0) then 1 else ((*) n (fac ((-) n 1))))
fac 3

--標準関数使う
fac_prod n = product [1..n]
fac_prod 3

--iter
--sicpにのってる
let {
	fac_iter max_num iter result
		|max_num < iter = result
		|otherwise = fac_iter max_num (iter + 1) result * iter; 
}

let {
	fac_sicp :: Int -> Int;
	fac_sicp n = fac_iter n 1 1
}

fac_sicp 3
fac_sicp 4

--もっと抽象化

let {
	iter_func f max_num iter result
		|max_num < iter = result
		|otherwise = iter_func f max_num (iter + 1) (f result iter);
}

let {
	fac_supper n = iter_func (*) n 1 1;
}
fac_supper 3
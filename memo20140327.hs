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

-- ※Ⅰ このファイルに記述してある関数を読み込むために、GHCIコマンドは「-- >」でコメントアウトしてあります。
-- ※Ⅱ 「-- >」と書いてあるものは、ghci上で動きます。



-- ------------------------------
-- 3.3 where?! (P.43 - P.47)
-- ------------------------------
-- 計算結果を中間結果に名前をつける

-- 前の章でやったもの
bmiTell :: Double -> Double -> String
bmiTell weight height
	| weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
	| weight / height ^ 2 <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"

-- bmiの計算を3回行っている
-- この値をwhereキーワードで変数に束縛
-- 計算が減るので速くなります

bmiTell' :: Double -> Double -> String
bmiTell' weight height
	| bmi <= 18.5 = "You're underweight, you emo, you!"
	| bmi <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
	where bmi = weight / height ^ 2

-- 他の値も一緒にwhereに入れてしまってかまわない
-- その場合、インデントをそろえないといけない
-- そろえないと文法エラー

bmiTell'' :: Double -> Double -> String
bmiTell'' weight height
	| bmi <= skinny = "You're underweight, you emo, you!"
	| bmi <= normal = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= fat = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
	where	bmi = weight / height ^ 2
 		skinny = 18.5
		normal = 25.0
		fat = 30.0

-- whereのスコープ
-- where節の変数はその関数からしか見えない
-- 同じ関数でも違うパターンだと共有されない

-- グローバルに定義するとOK
badGreeting :: String
badGreeting = "Oh! Pfft. It's you."

niceGreeting :: String
niceGreeting = "Hello! So very nice to see you,"

greet :: String -> String
greet "Juan" = niceGreeting ++ " Juan!"
greet "Fernando" = niceGreeting ++ " Fernando!"
greet name = badGreeting ++ " " ++ name

-- > greet "Juan"
-- > greet "Fernando"
-- > greet "hoge"

-- これだと共有されない
--	where	niceGreeting = "Hello! So very nice to see you,"
--		badGreeting = "Oh! Pfft. It's you."

-- パターンマッチとwhere
-- where束縛の中でもパターンマッチが使える

bmiTell''' :: Double -> Double -> String
bmiTell''' weight height
	| bmi <= skinny = "You're underweight, you emo, you!"
	| bmi <= normal = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= fat = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
	where	bmi = weight / height ^ 2
		(skinny, normal, fat) = (18.5, 25.0, 30.0)

-- イニシャルを返す関数

initials :: String -> String -> String
initials firstname lastname = [f] ++ "." ++ [l] ++ "."
	where	(f:_) = firstname
		(l:_) = lastname

-- > initials "Tomoya" "Baba"

-- whereブロックの中の関数
-- 定数だけでなく関数も定義できる

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
	where bmi weight height = weight / height ^ 2

-- > calcBmis [(69, 1.69)]

-- ------------------------------
-- 3.3 letItBe (P.47 - P.52)
-- ------------------------------

-- where節とよく似たもの
-- どこでも変数を束縛できる
-- let自身も式となるが、ガード間では共有されない
-- パターンマッチも使える

cylinder :: Double -> Double -> Double
cylinder r h =
	let	sideArea = 2 * pi * r * h
		topArea = pi * r ^ 2
	in	sideArea + 2 * topArea

-- > cylinder 2 4

-- 式なので値を持つ
-- > 4 * (let a = 9 in a + 1) + 2

-- ローカルスコープに関数を作れる
-- > [let square x = x * x in (square 5, square 3, square 2)]

-- セミコロン区切りで複数の変数が束縛できる
-- > (let a = 100; b = 200; c = 300 in a * b * c, let foo = "Hey "; bar = "there!" in foo ++ bar)

-- タプルを要素に分解
-- > (let (a, b, c) = (1, 2, 3) in a + b + c) * 100

-- リスト内包表記でのlet
-- 引数をw,hに束縛 > w,hをbmiに束縛
calcBmis' :: [(Double, Double)] -> [Double]
calcBmis' xs = [bmi | (w,h) <- xs, let bmi = w / h ^2]
-- > calcBmis' [(69,1.69)]

-- letはletより後ろと、出力(|より前)からみえる
-- (w,h) <- xsの部分はジェネレータと呼ばれ、let束縛は参照できない
calcBmis'' :: [(Double, Double)] -> [Double]
calcBmis'' xs = [bmi | (w,h) <- xs, let bmi = w / h ^2, bmi > 25.0]
-- > calcBmis'' [(69,1.69)]

-- GHCiでのlet
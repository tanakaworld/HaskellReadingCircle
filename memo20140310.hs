
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

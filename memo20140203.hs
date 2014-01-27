-- オリエンテーション
-- ------------------

-- これはコメント!!!

-- 基本的に毎週月曜に20時から1時間
	-- 祝日の場合はおやすみ

-- 担当者は立候補で
	-- 範囲は終ったら発表します
	-- 翌々週まで発表者を決めます(準備がよくできるから)
	-- みんなの前でサンプルコードを実行してください

-- 仕事に影響ないように
	-- がんばらない
	-- 長く細く
	-- でも予習はちょっぴりがんばってね

-- 本の中で閉じる
	-- トリッキーなことはしない
	-- 突然でてきた言葉はぐぐってきてもいい

-- このファイルはcodebreak;にあげてあります
-- https://codebreak.com/git/konnyakmannan/HaskellReadingCircle/
-- このリポジトリで欠席分のフォローをします
	-- できたら私以外にもリポジトリの更新をお願いしたい
	-- コミット制限があるので登録します

-- ------------------
-- イントロダクション
-- ------------------

-- Haskellの特徴

-- 純粋関数型 <=> 命令型，手続き型
	-- 関数!!!
	-- 値を変更できない

-- 副作用がない
	-- 副作用：値を返すだけ，何にもしない

-- 遅延評価

-- 静的型付け

-- ---------------------
-- 第一章 はじめの第一歩
-- ---------------------

-- 演算の優先順位

(50 * 100) - 4999
50 * 100 - 4999
50 * (100 - 4999)

-- ブール代数

True && False
True && True
False || True
not False
not (True && True)

-- 等価判定

5 == 5
1 == 0
5 /= 5
5 /= 4
"hello" == "hello"
-- これはエラー
5 == "llama"
-- 整数と浮動小数は比較できる
5 == 4.0
-- 足し算もできる
5 + 4.0

-- ---------------------
-- 関数呼び出し
-- ---------------------
-- '*'も関数→中置関数
-- 前置関数

-- 簡単な関数
-- かっこをつけない
succ 8

-- 最大・最小
min 9 10
min 3.4 3.2
max 100 101

-- 関数の優先順位は最も高い
succ 9 + max 5 4 + 1
(succ 9) + (max 5 4) + 1 -- 上と同じ

-- 注意
succ 9 * 10
succ (9 * 10)

-- 前置を中置に
div 92 10
92 `div` 10 -- バッククォート

-- ---------------------
-- 赤ちゃんの最初の関数
-- ---------------------
-- 関数の定義
doubleMe x = x + x
doubleMe 9
doubleMe 8.3

-- 二つの引数
doubleUS x y = x * 2 + y * 2
doubleUS 4 9
doubleUS 2.3 34.2

-- 組合せ
doubleUS 28 88 + doubleMe 123

-- doubleMeを使って
doubleUS x y = doubleMe x + doubleMe y
doubleUS 4 9
doubleUS 2.3 34.2
doubleUS 28 88 + doubleMe 123

-- if'式'
-- 文ではない
-- かならず値を返すelse
doubleSmallNumber x = if x > 100 then x else x * 2
doubleSmallNumber 2
doubleSmallNumber 150

-- アポストロフィー
-- 正格評価(遅延評価でない)
-- あるいは少し変更したバージョン
doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1
doubleSmallNumber' 2
doubleSmallNumber' 150

conanO'Brien = "It's a-me, Conan O'Brien!"
conanO'Brien
-- Haskellは関数を大文字ではじめない
-- 本文'…互いに交換できます．'→'どっちも同じものを指している'
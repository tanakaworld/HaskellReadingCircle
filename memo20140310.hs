
-- ���T ���̃t�@�C���ɋL�q���Ă���֐���ǂݍ��ނ��߂ɁAGHCI�R�}���h�́u-- >�v�ŃR�����g�A�E�g���Ă���܂��B
-- ���U �u-- >�v�Ə����Ă�����̂́Aghci��œ����܂��B



-- ------------------------------
-- 3.3 where?! (P.43 - P.47)
-- ------------------------------
-- �v�Z���ʂ𒆊Ԍ��ʂɖ��O������

-- �O�̏͂ł��������
bmiTell :: Double -> Double -> String
bmiTell weight height
	| weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
	| weight / height ^ 2 <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"

-- bmi�̌v�Z��3��s���Ă���
-- ���̒l��where�L�[���[�h�ŕϐ��ɑ���
-- �v�Z������̂ő����Ȃ�܂�

bmiTell' :: Double -> Double -> String
bmiTell' weight height
	| bmi <= 18.5 = "You're underweight, you emo, you!"
	| bmi <= 25.0 = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
	where bmi = weight / height ^ 2

-- ���̒l���ꏏ��where�ɓ���Ă��܂��Ă��܂�Ȃ�
-- ���̏ꍇ�A�C���f���g�����낦�Ȃ��Ƃ����Ȃ�
-- ���낦�Ȃ��ƕ��@�G���[

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

-- where�̃X�R�[�v
-- where�߂̕ϐ��͂��̊֐����炵�������Ȃ�
-- �����֐��ł��Ⴄ�p�^�[�����Ƌ��L����Ȃ�

-- �O���[�o���ɒ�`�����OK
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

-- ���ꂾ�Ƌ��L����Ȃ�
--	where	niceGreeting = "Hello! So very nice to see you,"
--		badGreeting = "Oh! Pfft. It's you."

-- �p�^�[���}�b�`��where
-- where�����̒��ł��p�^�[���}�b�`���g����

bmiTell''' :: Double -> Double -> String
bmiTell''' weight height
	| bmi <= skinny = "You're underweight, you emo, you!"
	| bmi <= normal = "You're supposedly normal.\
					\ Pfft, I bet you're ugly!"
	| bmi <= fat = "You're fat! Lose some weight, fatty!"
	| otherwise   = "You're a whale, congratulations!"
	where	bmi = weight / height ^ 2
		(skinny, normal, fat) = (18.5, 25.0, 30.0)

-- �C�j�V������Ԃ��֐�

initials :: String -> String -> String
initials firstname lastname = [f] ++ "." ++ [l] ++ "."
	where	(f:_) = firstname
		(l:_) = lastname

-- > initials "Tomoya" "Baba"

-- where�u���b�N�̒��̊֐�
-- �萔�����łȂ��֐�����`�ł���

calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
	where bmi weight height = weight / height ^ 2

-- > calcBmis [(69, 1.69)]

-- ------------------------------
-- 3.3 letItBe (P.47 - P.52)
-- ------------------------------

-- where�߂Ƃ悭��������
-- �ǂ��ł��ϐ��𑩔��ł���
-- let���g�����ƂȂ邪�A�K�[�h�Ԃł͋��L����Ȃ�
-- �p�^�[���}�b�`���g����

cylinder :: Double -> Double -> Double
cylinder r h =
	let	sideArea = 2 * pi * r * h
		topArea = pi * r ^ 2
	in	sideArea + 2 * topArea

-- > cylinder 2 4

-- ���Ȃ̂Œl������
-- > 4 * (let a = 9 in a + 1) + 2

-- ���[�J���X�R�[�v�Ɋ֐�������
-- > [let square x = x * x in (square 5, square 3, square 2)]

-- �Z�~�R������؂�ŕ����̕ϐ��������ł���
-- > (let a = 100; b = 200; c = 300 in a * b * c, let foo = "Hey "; bar = "there!" in foo ++ bar)

-- �^�v����v�f�ɕ���
-- > (let (a, b, c) = (1, 2, 3) in a + b + c) * 100

-- ���X�g����\�L�ł�let
-- ������w,h�ɑ��� > w,h��bmi�ɑ���
calcBmis' :: [(Double, Double)] -> [Double]
calcBmis' xs = [bmi | (w,h) <- xs, let bmi = w / h ^2]
-- > calcBmis' [(69,1.69)]

-- let��let�����ƁA�o��(|���O)����݂���
-- (w,h) <- xs�̕����̓W�F�l���[�^�ƌĂ΂�Alet�����͎Q�Ƃł��Ȃ�
calcBmis'' :: [(Double, Double)] -> [Double]
calcBmis'' xs = [bmi | (w,h) <- xs, let bmi = w / h ^2, bmi > 25.0]
-- > calcBmis'' [(69,1.69)]

-- GHCi�ł�let
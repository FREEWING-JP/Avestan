@echo off

rem ========== �m�F ==========

cd
echo �ȉ��� *.jpeg �� *.jpg �Ƀ��l�[�����܂��B
echo �L�����Z������ꍇ�́u����v�{�^���ŏI�����Ă��������B
pause

rem ========== ���s ==========

rename *.jpeg *.jpg
for /D /R %%i in ( *.* ) do (
	cd %%i
	rename *.jpeg *.jpg
)

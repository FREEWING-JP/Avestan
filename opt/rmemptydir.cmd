@echo off

set TMPFILE=$$$rmemptydir.tmp

rem ========== �m�F ==========

cd
echo �ȉ��̋�̃t�H���_���폜���܂��B
echo �L�����Z������ꍇ�́u����v�{�^���ŏI�����Ă��������B
pause

rem ========== ���s ==========

dir /AD /S /B /ON | sort /R > %TMPFILE%
for /f "delims=" %%i in (%TMPFILE%) do (
  rmdir "%%i" 2> nul
)
del %TMPFILE%

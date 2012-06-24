rem ネットワークドライブを張ってディレクトリををXCOPYでバックアップするスクリプト


set COPYFROM="testdir"
set COPYTO="\\samba\share"
set PASSWORD=PW
set USERNAME=USERNAME
set DRIVENAME=Y

for /F "tokens=1,2,3 delims=/, " %%i in ('date /t') do set SYSDATE=%%i%%j%%k
for /F "tokens=1,2,3 delims=:" %%i in ('echo %time%') do set SYSTIME=%%i%%j%%k
set SYSTIME=%SYSTIME:~0,-3%
set SYSDATETIME=%SYSDATE%%SYSTIME%

if exist %DRIVENAME%:\. net use %DRIVENAME%: /delete /yes
rem OSのファイル共有で一度つないでいたらこっち
net use %DRIVENAME%: %COPYTO%
rem OSのファイル共有で一度もつないでいなかったらこっち
rem net use z: %COPYTO% %PASSWORD% /user:%USERNAME%

mkdir %DRIVENAME%:\%SYSDATE%-%SYSTIME%

xcopy %COPYFROM% %DRIVENAME%:\%SYSDATE%-%SYSTIME% /E /V /C /F /H /R

rem sleep()の代わりに
ping localhost -n 5

net use %DRIVENAME%: /delete /yes
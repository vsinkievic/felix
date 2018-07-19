set MYDIRECTORY=%~dp0
set DLC=C:\progress\openedge
rem %DLC%\bin\proserve %MYDIRECTORY%/../../../Db/Sigma/sigma -S 10001
%DLC%\bin\proserve "%MYDIRECTORY%/FelixDB" -S 9000
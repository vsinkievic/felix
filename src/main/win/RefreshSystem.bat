@echo %1

SET FELIX-SYSTEM-NAME=%1

set DLC=C:\progress\openedge

%DLC%\bin\prowin -b -p ../progress/FindSystem.p -db FelixDB -S 9000 

:waitloop
IF EXIST %TEMP%"\compile.done" GOTO waitloopend
timeout /t 1
goto waitloop
:waitloopend

%DLC%\bin\prowin -b -p ../progress/waitForXrefs.p -db FelixDB -S 9000 

del %TEMP%\compile.done

type %TEMP%\%FELIX-SYSTEM-NAME%\errorfiles.txt

del %TEMP%\%FELIX-SYSTEM-NAME%\errorfiles.txt

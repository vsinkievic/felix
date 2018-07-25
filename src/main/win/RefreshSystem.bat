@echo %1

SET FELIX-SYSTEM-NAME=%1

set DLC=C:\progress\openedge

%DLC%\bin\prowin -b -p ../progress/FindSystem.p -db FelixDB -S 9000

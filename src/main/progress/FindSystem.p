{ttCompilerParams.i}

define variable SystemN as character no-undo.
SystemN = os-getenv("FELIX-SYSTEM-NAME").

    find first systems 
        where SystemN = systems.systemName.
            create ttSystemInfo.
            ttSystemInfo.fsystemName = systems.systemName.
            ttSystemInfo.flocalSourcePath = systems.localSourcePath.
            ttSystemInfo.fsystemPropath = systems.systemPropath.
            ttSystemInfo.fsystemDBparameters = systems.systemDBparameters.
        
temp-table ttSystemInfo:write-json ("file", os-getenv("TEMP") + "\FelixSystemInfo.json", yes).

os-command value("CompileSystem.bat " + OS-GETENV("TEMP") + "\FelixSystemInfo.json").
   
pause.
quit.

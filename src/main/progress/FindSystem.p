{ttCompilerParams.i}


function createIniFile returns character (ppropath as character):
    define variable iniFileName as character no-undo.
    iniFileName = os-getenv("TEMP") + "\propath.ini".
    output to value(iniFileName).
    put unformatted subst("[Startup] ~nPROPATH= .,&1~n~n[WinChar Startup]~nPROPATH= .,&1~n",ppropath).
    output close.
    return iniFileName.
end function.    

function getPath returns character():
    define variable path as character format "x(200)".
    path = program-name(2).
    path = replace(path,"\","/").
    path = substring (path,1,r-index(path, "/") - 1).
    file-info:file-name = path.
    return file-info:full-pathname.
end function.


define variable iniFileName as character no-undo.
define variable SystemN as character no-undo.
SystemN = os-getenv("FELIX-SYSTEM-NAME").

    find first systems 
        where SystemN = systems.systemName.
            create ttSystemInfo.
            ttSystemInfo.fsystemName = systems.systemName.
            ttSystemInfo.flocalSourcePath = systems.localSourcePath.
            ttSystemInfo.fsystemPropath = systems.systemPropath.
            ttSystemInfo.fsystemDBparameters = systems.systemDBparameters.
        

iniFileName = createIniFile(getPath() + "," + ttSystemInfo.flocalSourcePath).

os-delete value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName) recursive.

temp-table ttSystemInfo:write-json ("file", os-getenv("TEMP") + "\FelixSystemInfo.json", yes).

os-command value("CompileSystem.bat " + OS-GETENV("TEMP") + "\FelixSystemInfo.json" + " " + iniFileName).
   
pause.
quit.



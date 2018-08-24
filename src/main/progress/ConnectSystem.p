{ttCompilerParams.i}

define variable cDBname as character no-undo.

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

find ttSystemInfo.

if ttSystemInfo.fsystemDBparameters <> ""
    then do:
        run createDB.p(input ttSystemInfo.fsystemDBparameters, output cDBname).
        //message cDBname.
        display cDBname format "x(100)" with size 50 by 20.
        connect value(ttSystemInfo.fsystemDBparameters + "\" + cDBname) -1.
    end.

os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).

run CompileXref.p(input ttSystemInfo.flocalSourcePath, input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\").

if ttSystemInfo.fsystemDBparameters <> ""
    then do:
        disconnect value(cDBname).
    end.
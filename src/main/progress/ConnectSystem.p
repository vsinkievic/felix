{ttCompilerParams.i}

define variable cDBname as character no-undo.

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

find ttSystemInfo.

//message ttSystemInfo.flocalSourcePath + "\" ttSystemInfo.fsystemName.
run createDB.p(input ttSystemInfo.fsystemDBparameters, output cDBname).

connect value(ttSystemInfo.fsystemDBparameters + "\" + cDBname) -1.

os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).

run CompileXref.p(input ttSystemInfo.flocalSourcePath, input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\").

disconnect value(cDBname).
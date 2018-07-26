{ttCompilerParams.i}

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

find ttSystemInfo.

//message ttSystemInfo.flocalSourcePath + "\" ttSystemInfo.fsystemName.
connect value(ttSystemInfo.fsystemDBparameters).
//run createDB.p(input ttSystemInfo.flocalSourcePath + "\", input ttSystemInfo.fsystemName).

os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).

run CompileXref.p(input ttSystemInfo.flocalSourcePath, input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\").
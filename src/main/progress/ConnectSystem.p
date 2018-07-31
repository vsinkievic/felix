{ttCompilerParams.i}

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

find ttSystemInfo.

//message ttSystemInfo.flocalSourcePath + "\" ttSystemInfo.fsystemName.
run createDB.p(input ttSystemInfo.fsystemDBparameters).

//connect value(ttSystemInfo.fsystemDBparameters).

os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).

run CompileXref.p(input ttSystemInfo.flocalSourcePath, input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\").
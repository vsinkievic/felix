{ttCompilerParams.i}

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

//os-delete value(os-getenv("JSON-LOCATION")).

find ttSystemInfo.

connect value(ttSystemInfo.fsystemDBparameters).

os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).








output to "Petriukas.txt".                                  
message propath.
/*//display ttSystemInfo.fsystemDBparam skip(1).              */
/*display os-getenv("JSON-LOCATION") format "x(80)"           */
/*    with width 400.                                         */
/*    display skip(2).                                        */
/*    for each ttSystemInfo no-lock:                          */
/*        display ttSystemInfo with stream-io width 300 1 col.*/
/*    end.                                                    */

output close.
run CompileXref.p(input ttSystemInfo.flocalSourcePath, input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\").
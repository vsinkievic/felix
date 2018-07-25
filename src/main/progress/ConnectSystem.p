{ttCompilerParams.i}

temp-table ttSystemInfo:read-json("file",os-getenv("JSON-LOCATION"),"empty").

find ttSystemInfo.

propath = ttSystemInfo.fsystemPropath.

connect value(ttSystemInfo.fsystemDBparameters).


os-create-dir value(os-getenv("TEMP") + "/" + ttSystemInfo.fsystemName).


compile value(ttSystemInfo.flocalSourcePath + "\Buttons.i") save xref value(os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\" + subst("&1.xref", "Buttons.i")).
compile value(ttSystemInfo.flocalSourcePath + "\DataSet.i") save xref value(os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\" + subst("&1.xref", "DataSet.i")).


/*output to "Petriukas.txt".                                  */
/*//display ttSystemInfo.fsystemDBparam skip(1).              */
/*display os-getenv("JSON-LOCATION") format "x(80)"           */
/*    with width 400.                                         */
/*    display skip(2).                                        */
/*    for each ttSystemInfo no-lock:                          */
/*        display ttSystemInfo with stream-io width 300 1 col.*/
/*    end.                                                    */

       
output close
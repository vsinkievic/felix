//DON'T RUN THIS

{trimPathFunction.i}.

define variable cWholeLine as character no-undo.
define variable cSourceName as character no-undo.
define variable cFileName as character no-undo.
define variable cLineNumber as character no-undo.
define variable cXrefType as character no-undo.
define variable cXrefInformation as character no-undo.
define variable cCompileUnit as character no-undo.
define variable i as integer no-undo.
define variable i2 as integer no-undo.
define variable i3 as integer no-undo.
define input parameter cPath as character no-undo.
define variable cProPath as character init "system/;migration/;integration/".
define variable cCompilePath as character no-undo init "/u1/env/bankcp/indigo/svn-trunk/".
define variable cSourePath as character no-undo.

input from value(cPath).

        repeat:
            
            import unformatted cWholeLine.
            
            //display cWholeLine format "x(200)" with width 210.
            
            cSourceName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cFileName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cLineNumber = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cXrefType = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cXrefInformation = substring(cWholeLine, index(cWholeLine, " ") + 1).
            
            
/*            import delimiter " " cSourceName      */
/*                                 cFileName        */
/*                                 cLineNumber      */
/*                                 cXrefType        */
/*                                 cXrefInformation.*/
            
            cXrefInformation = trim(cXrefInformation, "~"").                   
            
            cSourePath = trimPath(input cProPath, input cCompilePath, input cSourceName).
            
            if cXrefType = "RUN" or cXrefType = "NEW" or cXrefType = "INCLUDE" or cXrefType = "COMPILE" 
            then do:
                
                if index(cXrefInformation, " ") <> 0 or index(cXrefInformation, ",") <> 0
                then do:
                    cXrefInformation = entry (1, cXrefInformation, " ").
                    cXrefInformation = entry (1, cXrefInformation, ",").
                end.
/*                else if index(cXrefInformation, ",") <> 0               */
/*                then do:                                                */
/*                    cXrefInformation = entry (1, cXrefInformation, ",").*/
/*                end.                                                    */
                
                
                repeat i = 1 to num-entries(cFileName, "/"):
                end.
                repeat i2 = 1 to num-entries(cSourceName, "/"):
                end.
                
                if cXrefType = "COMPILE" 
                then do:
                    cXrefInformation = trimPath(input cProPath, input cCompilePath, input cXrefInformation).
                    cCompileUnit = cXrefInformation.
                end.
                
                create files.
                    assign
                        files.fileName = entry(i - 1, cFileName, "/")
                        files.sourceName = entry(i2 - 1, cSourceName, "/")
                        files.sourcePath = cSourePath
                        files.line = integer(cLineNumber)
                        files.type = cXrefType
                        files.info = cXrefInformation
                        files.compileUnit = cCompileUnit
                        files.system = "Indigo".
            end.
            else if cXrefType = "CLASS" and (cXrefInformation matches ("*INHERITS*") or cXrefInformation matches ("*IMPLEMENTS*")) //pakeisti matches á index <> 0
            then do:
                if cXrefInformation matches ("*INHERITS*") //pakeisti matches á index <> 0
                then do:
                    cXrefInformation = substring(cXrefInformation, index(cXrefInformation, "INHERITS")).
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                else if cXrefInformation matches ("*IMPLEMENTS*") //pakeisti matches á index <> 0
                then do:
                    cXrefInformation = substring(cXrefInformation, index(cXrefInformation, "IMPLEMENTS")).
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                create files.
                    assign
                        files.fileName = entry(i - 1, cFileName, "/")
                        files.sourceName = entry(i2 - 1, cSourceName, "/")
                        files.sourcePath = cSourePath
                        files.line = integer(cLineNumber)
                        files.type = cXrefType
                        files.info = cXrefInformation //substring(cXrefInformation, index(cXrefInformation, ",") + 1).
                        files.compileUnit = cCompileUnit
                        files.system = "Indigo".
            end.
            
        end.

input close.
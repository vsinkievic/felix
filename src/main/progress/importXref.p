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
define input parameter cSystem as character no-undo.
define variable cProPath as character init "system/;migration/;integration/".
define variable cCompilePath as character no-undo init "/u1/env/bankcp/indigo/svn-trunk/".
define variable cSourePath as character no-undo.

input from value(cPath).

        repeat:
            
            import unformatted cWholeLine.
            cWholeLine = replace(cWholeLine,"\","/").
            cSourceName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cFileName = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cLineNumber = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cWholeLine = substring(cWholeLine, index(cWholeLine, " ") + 1).
            cXrefType = substring(cWholeLine, 1, index(cWholeLine, " ")).
            cXrefInformation = substring(cWholeLine, index(cWholeLine, " ") + 1).
            
            cXrefInformation = trim(cXrefInformation, "~"").                   
            
            cSourePath = trimPath(input cPath, input cProPath, input cCompilePath, input cSourceName).
            
            repeat i = 0 to num-entries(cFileName, "/"):
            end.
            repeat i2 = 0 to num-entries(cSourceName, "/"):
            end.
            
            if cXrefType = "RUN" or cXrefType = "NEW" or cXrefType = "INCLUDE" or cXrefType = "COMPILE"
            then do:
                if index(cXrefInformation, " ") <> 0 or index(cXrefInformation, ",") <> 0
                then do:
                    cXrefInformation = entry (1, cXrefInformation, " ").
                    cXrefInformation = entry (1, cXrefInformation, ",").
                end.
                
                if cXrefType = "COMPILE" 
                then do:
                    cXrefInformation = trimPath(input cPath, input cProPath, input cCompilePath, input cXrefInformation).
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
                        files.system = cSystem.
            end.
            else if cXrefType = "CLASS" and (cXrefInformation matches ("*INHERITS*") or cXrefInformation matches ("*IMPLEMENTS*"))
            then do:
                
                if cXrefInformation matches ("*INHERITS*")
                then do:
                    cXrefInformation = substring(cXrefInformation, index(cXrefInformation, "INHERITS")).
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                else if cXrefInformation matches ("*IMPLEMENTS*")
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
                        files.info = cXrefInformation
                        files.compileUnit = cCompileUnit
                        files.system = cSystem.
            end.
            else if cXrefType = "SEARCH"
            then do:
                cXrefInformation = replace(cXrefInformation,"DATA-MEMBER ","").
                cXrefInformation = replace(cXrefInformation,"INHERITED-DATA-MEMBER ","").
                cXrefInformation = replace(cXrefInformation," TEMPTABLE","").
                cXrefInformation = replace(cXrefInformation," WHOLE-INDEX","").
                cXrefInformation = replace(cXrefInformation," TABLE-SCAN","").
                cXrefInformation= trim(cXrefInformation).
               
                cXrefInformation = entry(2,cXrefInformation," ").
              
                create fieldDB.
                    assign
                        fieldDB.fileName = entry(i - 1, cFileName, "/")
                        fieldDB.sourceName = entry(i2 - 1, cSourceName, "/")
                        fieldDB.sourcePath = cSourePath
                        fieldDB.line = integer(cLineNumber)
                        fieldDB.type = "INDEX"
                        fieldDB.info = cXrefInformation
                        fieldDB.compileUnit = cCompileUnit
                        fieldDB.system = cSystem.
            end.
            else if cXrefType = "INVOKE"
            then do:
                if index(cXrefInformation, ",") <> 0
                then do:
                    cXrefInformation = substring(cXrefInformation, 1, index(cXrefInformation, ",") - 1).
                end.
                if cLineNumber = "IMPLICIT"
                then do:
                    cLineNumber = "0".
                    cXrefType = "IMPLICIT " + cXrefType.
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
                        files.system = cSystem.
            end.
            else if cXrefType = "ACCESS" or cXrefType = "UPDATE" or cXrefType = "REFERENCE" or cXrefType = "DELETE"
            then do:
                if index(cXrefInformation, "INHERITED") <> 0 or index(cXrefInformation, "PUBLIC") <> 0
                then do:
                    create files.
                    assign
                        files.fileName = entry(i - 1, cFileName, "/")
                        files.sourceName = entry(i2 - 1, cSourceName, "/")
                        files.sourcePath = cSourePath
                        files.line = integer(cLineNumber)
                        files.type = cXrefType
                        files.info = cXrefInformation 
                        files.compileUnit = cCompileUnit
                        files.system = cSystem.
                end.
                else if index(cXrefInformation, "TEMPTABLE") = 0 and 
                        index(cXrefInformation, "SHARED") = 0 and
                        index(cXrefInformation, "DATA-MEMBER") = 0 and
                        index(cXrefInformation, "WORKFILE") = 0 and
                        index(cXrefInformation, "SEQUENCE") = 0 and
                        index(cXrefInformation, "PROPERTY") = 0
                then do:
                    cXrefInformation = trim(cXrefInformation).
                    if index(cXrefInformation, ".") <> 0
                    then cXrefInformation = substring(cXrefInformation, index(cXrefInformation,".") + 1).
                    cXrefInformation = replace(cXrefInformation," ",".").
                    
                    create fieldDB.
                    assign
                        fieldDB.fileName = entry(i - 1, cFileName, "/")
                        fieldDB.sourceName = entry(i2 - 1, cSourceName, "/")
                        fieldDB.sourcePath = cSourePath
                        fieldDB.line = integer(cLineNumber)
                        fieldDB.type = cXrefType
                        fieldDB.info = cXrefInformation
                        fieldDB.compileUnit = cCompileUnit
                        fieldDB.system = cSystem.
                end.
            end.
        end.

input close.
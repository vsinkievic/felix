//DON'T RUN THIS

{trimPathFunction.i}.

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
            import delimiter " " cSourceName
                                 cFileName
                                 cLineNumber
                                 cXrefType
                                 cXrefInformation.
            if index(cXrefInformation, " ") <> 0
            then do:
                cXrefInformation = entry (1, cXrefInformation, " ").
            end.
            else do:
                cXrefInformation = entry (1, cXrefInformation, ",").
            end.
            
            cSourePath = trimPath(input cProPath, input cCompilePath, input cSourceName).
            
            if cXrefType = "RUN" or cXrefType = "NEW" or cXrefType = "INCLUDE" or cXrefType = "COMPILE" 
            then do:
                repeat i = 2 to num-entries(cFileName, "/"):
                end.
                repeat i2 = 2 to num-entries(cSourceName, "/"):
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
                        files.compileUnit = cCompileUnit.
            end.
        end.

input close.



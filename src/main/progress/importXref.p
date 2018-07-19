//DON'T RUN THIS

define variable cSourceName as character no-undo.
define variable cFileName as character no-undo.
define variable cLineNumber as character no-undo.
define variable cXrefType as character no-undo.
define variable cXrefInformation as character no-undo.
define variable i as integer no-undo.
define variable i2 as integer no-undo.
define variable i3 as integer no-undo.
define input parameter cPath as character no-undo.

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
            if cXrefType = "RUN" or cXrefType = "NEW" or cXrefType = "INCLUDE" or cXrefType = "COMPILE" 
            then do:
                repeat i = 2 to num-entries(cFileName, "/"):
                end.
                repeat i2 = 2 to num-entries(cSourceName, "/"):
                end.
                
                if cXrefType = "COMPILE" 
                then do:
                    repeat i3 = 2 to num-entries(cXrefInformation, "/"):
                    end.
                    cXrefInformation = entry (i3 - 1, cXrefInformation, "/").
                end.
                
                create files.
                    assign
                        files.fileName = entry(i - 1, cFileName, "/")
                        files.sourceName = entry(i2 - 1, cSourceName, "/")
                        files.sourcePath = cSourceName
                        files.line = integer(cLineNumber)
                        files.type = cXrefType
                        files.info = cXrefInformation.
                        
            end.
        end.

input close.
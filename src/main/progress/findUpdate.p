{ttDetails.i}

define input parameter vName as character.
define output parameter table for ttDetails.
define input parameter vSystem as character.
define input parameter vIsDetailed as logical.

for each fieldDB no-lock where
         fieldDB.system = vSystem and
         fieldDB.type = "UPDATE" and
         fieldDB.info = vName 
         by fieldDB.compileUnit:
             
    if vIsDetailed 
    then do:
        create ttDetails.
        assign
            ttDetails.system = fieldDB.system
            ttDetails.compileUnit = fieldDB.compileUnit
            ttDetails.fileName = fieldDB.fileName
            ttDetails.sourceName = fieldDB.sourceName
            ttDetails.sourcePath = fieldDB.sourcePath
            ttDetails.type = fieldDB.type
            ttDetails.line = fieldDB.line
            ttDetails.info = fieldDB.info.
    end.
    else do:        
        find first ttDetails where fieldDB.compileUnit = ttDetails.compileUnit no-error.
        if not available ttDetails
        then do:
            create ttDetails.
            ttDetails.compileUnit = fieldDB.compileUnit.
        end.
    end.
end.

{ttDetails.i}

define input parameter vName as character.
define output parameter table for ttDetails.
define input parameter vSystem as character.
define input parameter vIsDetailed as logical.

if index(vName, ".p") <> 0 then
    vName = replace(vName,".p","").
    
if index(vName, ".cls") <> 0 then
    vName = replace(vName,".cls","").
    
if index(vName, ".i") <> 0 then
    vName = replace(vName,".i","").
    
for each fieldDB no-lock where
         (fieldDB.type = "REFERENCE" or
         fieldDB.type = "DELETE" or
         fieldDB.type = "ACCESS" or
         fieldDB.type = "UPDATE") and
         (fieldDB.info matches("*~~." + vName) or
         fieldDB.info = vName or
         fieldDB.info matches ("*~~." + vName + ":*"))
         by fieldDB.compileUnit:
             
    if vIsDetailed 
    then do:
        create ttDetails.
        ttDetails.system = fieldDB.system.
        ttDetails.compileUnit = fieldDB.compileUnit.
        ttDetails.fileName = fieldDB.fileName.
        ttDetails.sourceName = fieldDB.sourceName.
        ttDetails.sourcePath = fieldDB.sourcePath.
        ttDetails.type = fieldDB.type.
        ttDetails.line = fieldDB.line.
        ttDetails.info = fieldDB.info.
    end.
    else do:
         find first ttDetails where 
                    ttDetails.compileUnit = fieldDB.compileUnit no-error.
         if not available ttDetails
         then do:
             create ttDetails.
             ttDetails.compileUnit = fieldDB.compileUnit.
         end.
    end.
end.
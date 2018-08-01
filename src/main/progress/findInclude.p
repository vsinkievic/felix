{ttDetails.i}

define input parameter vName as character.
define output parameter table for ttDetails.
define input parameter vSystem as character.
define input parameter vIsDetailed as logical.

for each files no-lock where 
         files.type = "INCLUDE" and 
         files.system = vSystem and
         (files.info matches ("*/" + vName) or
         files.info matches("*/" + vName + "~~.i") or
         files.info = vName or
         files.info matches(vName + "~~.i"))
         by files.compileUnit:
             
    if vIsDetailed 
    then do:
        create ttDetails.
        ttDetails.system = files.system.
        ttDetails.compileUnit = files.compileUnit.
        ttDetails.fileName = files.fileName.
        ttDetails.sourceName = files.sourceName.
        ttDetails.sourcePath = files.sourcePath.
        ttDetails.type = files.type.
        ttDetails.line = files.line.
        ttDetails.info = files.info.
    end.
    else do:
         find first ttDetails where 
                    ttDetails.compileUnit = files.compileUnit no-error.
         if not available ttDetails
         then do:
             create ttDetails.
             ttDetails.compileUnit = files.compileUnit.
         end.
    end.
end.

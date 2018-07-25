{ttDetails.i}

define input parameter cName as character.
define output parameter table for ttDetails.
define input parameter cSystem as character.

for each fieldDB no-lock where
         fieldDB.system = cSystem and
         fieldDB.type = "ACCESS" and
         fieldDB.info = cName
         by fieldDB.compileUnit:
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

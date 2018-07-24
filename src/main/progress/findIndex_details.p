{ttDetails.i}

define input parameter cName as character.
define output parameter table for ttDetails.
define input parameter cSystem as character.

for each files no-lock where
         files.system = cSystem and
         files.type = "INDEX" and
         files.info = cName
         by files.compileUnit:
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

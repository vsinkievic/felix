{ttDetails.i}

define input parameter cName as character.
define output parameter table for ttDetails.
define input parameter cSystem as character.

for each files no-lock where files.type = "INCLUDE" and 
         files.system = cSystem and
         (substring(files.info, index(files.info, '/') + 1) = cName or
         substring(files.info, index(files.info, '/') + 1) matches (cName + "*") or
         substring(files.info, index(files.info, '/') + 1) matches ("*" + cName + "*")):
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


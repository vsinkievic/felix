define input parameter cName as character.

define temp-table ttOutput like files.

define output parameter table for ttOutput.


for each files no-lock where files.type = "INCLUDE" and 
    (substring(files.info, index(files.info, '/') + 1) = cName or
     substring(files.info, index(files.info, '/') + 1) matches (cName + "*") or
     substring(files.info, index(files.info, '/') + 1) matches ("*" + cName + "*")):
         create ttOutput.
         ttOutput.compileUnit = files.compileUnit.
         ttOutput.fileName = files.fileName.
         ttOutput.sourceName = files.sourceName.
         ttOutput.sourcePath = files.sourcePath.
         ttOutput.type = files.type.
         ttOutput.line = files.line.
         ttOutput.info = files.info.
end.


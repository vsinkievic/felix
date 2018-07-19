define input parameter cName as character.

define temp-table ttOutput like FelixDB.files.

define output parameter table for ttOutput.

for each files where files.info matches ("*" + string(cName) + "*" + ".i " + "*") no-lock:
display files.line.
    create ttOutput.
    ttOutput.fileName = files.fileName.
    ttOutput.sourceName = files.sourceNam.
    ttOutput.sourcePath = files.sourcePath.
    ttOutput.type = files.type.
    ttOutput.line = files.line.
    ttOutput.info = files.info.
end.
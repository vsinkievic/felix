define input parameter cName as character.

define temp-table ttOutput like files.

define output parameter table for ttOutput.


for each files no-lock where files.type = "INCLUDE" and 
    (substring(files.info, index(files.info, '/') + 1) = cName or
     substring(files.info, index(files.info, '/') + 1) matches ("*" + cName + "*")) by files.compileUnit:
        find first ttOutput where files.compileUnit = ttOutput.compileUnit no-error.
        if not available ttOutput
        then do:
            create ttOutput.
            ttOutput.compileUnit = files.compileUnit.
        end.
end.


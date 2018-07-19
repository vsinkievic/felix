define temp-table ttClasses no-undo
    field compileUnit as character
    . 
define input parameter cName as character.
define output parameter table for ttClasses.

for each FelixDB.files no-lock where 
                 files.type = "NEW" and
                 (files.info matches("*." + cName) or
                 files.info matches("*" + cName )): 
     find first ttClasses where files.compileUnit = ttClasses.compileUnit no-error.
     if not available ttClasses
     then do:
         create ttClasses.
         ttClasses.compileUnit = files.compileUnit.
     end.
end.

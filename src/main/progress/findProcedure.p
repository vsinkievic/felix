define temp-table ttProcedures no-undo
    field compileUnit as character
    . 
define input parameter pName as character.
define output parameter table for ttProcedures.

for each FelixDB.files no-lock where 
                 files.type = "RUN" and
                 (files.info matches("*" + pName) or
                 files.info matches("*" + pName + ".p")): 
     find first ttProcedures where files.compileUnit = ttProcedures.compileUnit no-error.
     if not available ttProcedures
     then do:
         create ttProcedures.
         ttProcedures.compileUnit = files.compileUnit.
     end.
end.

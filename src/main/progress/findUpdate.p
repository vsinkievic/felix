{ttDetails.i}

define input parameter cName as character.
define output parameter table for ttDetails.
define input parameter cSystem as character.

for each fieldDB no-lock where
         fieldDB.system = cSystem and
         fieldDB.type = "UPDATE" and
         fieldDB.info = cName 
         by fieldDB.compileUnit:
     find first ttDetails where fieldDB.compileUnit = ttDetails.compileUnit no-error.
     if not available ttDetails
     then do:
         create ttDetails.
         ttDetails.compileUnit = fieldDB.compileUnit.
     end.
end.

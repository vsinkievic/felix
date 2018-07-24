{ttDetails.i}

define input parameter cName as character.
define output parameter table for ttDetails.
define input parameter cSystem as character.

for each files no-lock where 
         files.system = cSystem and
         (files.type = "NEW" or files.type = "CLASS") and
         (files.info matches("*." + cName) or
         files.info = cName)
         by files.compileUnit:
     find first ttDetails where files.compileUnit = ttDetails.compileUnit no-error.
     if not available ttDetails
     then do:
         create ttDetails.
         ttDetails.compileUnit = files.compileUnit.
     end.
end.

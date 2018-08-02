{getMethodNameFromPath.i}


define input parameter cName as character no-undo.
define input parameter cSystem as character no-undo.

define variable iCount as integer no-undo init 0.
define variable iDepth as integer no-undo init 5.
define variable cLine as character no-undo.

define temp-table ttUp
    field f1 as character
    field type as character.

define temp-table ttDown
    field f1 as character
    field type as character.


define output parameter table for ttUp. 
define output parameter table for ttDown.


for each files no-lock where (files.compileunit matches ("*/" + cName) or
                    files.compileunit matches ("*/" + cName + ".*")) and
                    (files.type = "RUN" or
                    files.type = "INCLUDE" or
                    files.type = "NEW" or 
                    files.type = "CLASS" or 
                    files.type = "INVOKE" or 
                    files.type = "IMPLICIT INVOKE" and
                    files.system = cSystem)
                    by files.info:
                find first ttUp where getNameFromPath(files.info) = ttUp.f1 no-error.
                if not available ttUp
                then do:
                    create ttUp.
                    ttUp.f1 = getNameFromPath(files.info).
                    ttUp.type = files.type.
                end.                
end.


for each files no-lock where 
         files.system = cSystem and
               ( (files.type = "NEW" or 
                 files.type = "CLASS" or 
                 files.type = "INVOKE" or 
                 files.type = "IMPLICIT INVOKE" or 
                 files.type = "ACCESS" or 
                 files.type = "UPDATE") and
                 (files.info matches("*." + cName) or
                 files.info = cName or
                 files.info matches ("*." + cName + ":*"))
                 or
                 (files.type = "RUN" and
                 (files.info matches("*/" + cName) or
                 files.info matches("*/" + cName + ".p") or
                 files.info = cName or
                 files.info matches (cName + ".p")))
                 or
                 (files.type = "INCLUDE" and 
                 (files.info matches ("*/" + cName) or
                 files.info matches("*/" + cName + ".i") or
                 files.info = cName or
                 files.info matches(cName + ".i")))
               )
                 by files.compileUnit:

         find first ttDown where getNameFromPath(files.compileUnit) = ttDown.f1 no-error.
         if not available ttDown
         then do:
             create ttDown.
             ttDown.f1 = getNameFromPath(files.compileUnit).
             ttDown.type = files.type.
         end.
end.

    
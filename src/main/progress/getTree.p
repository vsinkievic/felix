{getNameFromPath.i}


define input parameter cName as character no-undo.
define input parameter cSystem as character no-undo.

define variable iCount as integer no-undo init 0.
define variable iDepth as integer no-undo init 5.
define variable cLine as character no-undo.

define temp-table ttCalling
    field f1 as character
    field type as character.
    
define temp-table ttList
    field f1 as character
    field type as character.
    
define output parameter table for ttCalling.
define output parameter table for ttList.

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

         find first ttCalling where getNameFromPath(files.compileUnit) = ttCalling.f1 no-error.
         if not available ttCalling
         then do:
             create ttCalling.
             ttCalling.f1 = getNameFromPath(files.compileUnit).
             ttCalling.type = files.type.
         end.
end.


for each files no-lock where (files.fileName = cName or
                    files.fileName matches (cName + ".*")) and
                    (files.type = "RUN" or
                    files.type = "NEW" or 
                    files.type = "CLASS" or 
                    files.type = "INVOKE" or 
                    files.type = "IMPLICIT INVOKE" and
                    files.system = cSystem):
                find first ttList where getNameFromPath(files.info) = ttList.f1 no-error.
                if not available ttList
                then do:
                    create ttList.
                    ttList.f1 = getNameFromPath(files.info).
                    ttList.type = files.type.
                end.
                
end.





    

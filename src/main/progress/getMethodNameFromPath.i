/*-------------- FUNCTION TO GET FILE NAME FROM PATH -------------------- */

function getNameFromPath returns character (input cPath as character):
    
    do while index (cPath, '/') > 0:
        cPath = substring(cPath, index(cPath, '/') + 1).
    end.
    
    if not cPath matches ('*.cls')
    then do:
        if (index (cPath, ".") > 0) and (index(cPath, ".") < length(cPath) - 2)
        then do:
            cPath = substring(cPath, index(cPath, ".") + 1).
        end.
    end.
        
    return cPath.
    
end function.
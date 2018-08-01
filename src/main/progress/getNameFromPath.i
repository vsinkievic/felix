/*-------------- FUNCTION TO GET FILE NAME FROM PATH -------------------- */

function getNameFromPath returns character (input cPath as character):
    
    do while index (cPath, '/') > 0:
        cPath = substring(cPath, index(cPath, '/') + 1).
    end.
    
    if index (cPath, ":") > 0 
    then do:
        cPath = substring(cPath, 1, index(cPath, ":") - 1).
    end.
    
    do while num-entries(cPath, ".") > 1 and 
            not 
            (entry(2, cPath, ".") = "cls" or 
            entry(2, cPath, ".") = "p" or 
            entry(2, cPath, ".") = "i"):
        cPath = substring(cPath, index(cPath, ".") + 1).
    end.        
        
    return cPath.
    
end function.

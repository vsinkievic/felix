/*-------------- FUNCTION TO GET FILE NAME FROM PATH -------------------- */

function getNameFromPath returns character (input cPath as character):
    do while index (cPath, '/') > 0:
        cPath = substring(cPath, index(cPath, '/') + 1).
    end.
    return cPath.
end function.

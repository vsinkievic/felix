define variable i4 as integer no-undo.

function trimPath returns character (pSysPath as character, pProPath as character, pCompilePath as character, pAbsolutPath as character):
    pAbsolutPath = replace(pAbsolutPath, pCompilePath, "").
    repeat i4 = 1 to num-entries(pProPath, ";"):
        if index(pAbsolutPath, entry(i4, pProPath, ";")) <> 0
        then do:
           pAbsolutPath = replace(pAbsolutPath, entry(i4, pProPath, ";"), "").
        end.  
    end.  
    pAbsolutPath = replace(pAbsolutPath, pSysPath, "").
    return pAbsolutPath.
end function.
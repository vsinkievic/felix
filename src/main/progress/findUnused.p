{ttUnused.i}

define input parameter vSystem as character no-undo.
define output parameter table for ttUnused.    
define variable vName as character no-undo.
define buffer bFiles for files.

 for each files no-lock where
          files.system = vSystem and
          files.type = "COMPILE":
    vName = entry(num-entries(files.info,"/"),files.info,"/").
    if index(files.info, ".p") <> 0 
    then do:     
        vName = replace(vName,".p","").
        find first bFiles where
                   bFiles.system = vSystem and
                   bFiles.type <> "COMPILE" and
                   (bFiles.info matches ("*/" + vName + ".p") or
                   bFiles.info = vName or
                   bFiles.info matches("*/" + vName) or
                   bFiles.info matches (vName + ".p")) no-lock no-error.
        if available bFiles 
        then do:
            create ttUnused.
            ttUnused.type = "PROCEDURE".
            ttUnused.compileUnit = files.compileUnit.
            ttUnused.name = vName.
        end.
    end.
    else if index(files.info, ".cls") <> 0
    then do:
        vName = replace(vName,".cls","").
        find first bFiles where
                   bFiles.system = vSystem and
                   bFiles.type <> "COMPILE" and
                   bFiles.info matches("*." + vName) or
                   bFiles.info = vName or
                   bFiles.info matches ("*." + vName + ":*") no-lock no-error.
        if not available bFiles
        then do:
            create ttUnused.
            ttUnused.type = "CLASS".
            ttUnused.compileUnit = files.compileUnit.
            ttUnused.name = vName.
        end.
    end.
    else if index(files.info, ".i") <> 0
    then do:
        find first bFiles where
                   bFiles.system = vSystem and
                   bFiles.type <> "COMPILE" and
                   (bFiles.info matches ("*/" + vName) or
                   bFiles.info = vName) no-lock no-error.
        if not available bFiles
        then do:
            create ttUnused.
            ttUnused.type = "INCLUDE".
            ttUnused.compileUnit = files.compileUnit.
            ttUnused.name = vName.
        end.
    end.
end.
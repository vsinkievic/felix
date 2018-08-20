{ttUsed.i}

//define input parameter vSystem as character no-undo.
define variable vSystem as character no-undo.
define variable vName as character no-undo.
define variable vCompileUnit as character no-undo.
define variable i as integer no-undo.
define variable vEntryPoints as character format "x(100)" no-undo extent 100.

/*------Funckiju apsibrëþimas-------*/
function detailLevel returns integer (compilekazkas as character) forward.

vSystem = "indigo".

find first systems where systems.systemName = vSystem.

if length(systems.entryPoints) = r-index(systems.entryPoints,",") then
    systems.entryPoints = substring(systems.entryPoints,1,length(systems.entryPoints) - 1).

repeat i = 1 to num-entries(systems.entryPoints, ",").
    vEntryPoints = entry(i,systems.entryPoints,",").
    detailLevel(vEntryPoints[i]).
    isUsing(vSystem).
end.        

function detailLevel returns integer (compileUnitNext as character):
    define buffer bfiles for files.
    define buffer ufiles for files no-lock.    
    define buffer bUsed for ttUsed exclusive-lock.
    
    do:
        find first ufiles no-lock where ufiles.compileUnit matches ("*" + compileUnitNext + "*") and
            ufiles.system = vSystem and
            (ufiles.type = "COMPILE" or 
            ufiles.type = "INCLUDE") no-lock no-error.
        if available ufiles 
            then do: 
                vName = entry(num-entries(ufiles.info,"/"),ufiles.info,"/").
                vCompileUnit = ufiles.info. //cia tikrinamo dalyko info laukas
        
                for each bfiles no-lock where 
                    (bFiles.info <> vCompileUnit and
                    bFiles.compileUnit = ufiles.compileUnit and 
                    bFiles.system = vSystem and
                    ((index(bfiles.info, ".p") <> 0) or 
                    (index(bfiles.info, ".cls") <> 0) or 
                    (index(bfiles.info, ".i") <> 0))):      
                    
                    find bUsed where bUsed.info = bFiles.info no-lock no-error.
                    if not available bUsed
                        then do:
                            create bUsed.
                            bUsed.compileUnit = bfiles.info.
                            bUsed.fileName = bfiles.fileName.
                            bUsed.type = bFiles.type.
                            bUsed.system = bFiles.system.
                            bUsed.info = "***PROGRESS SYSTEM FILE***".
                            bUsed.isUsed = false.
                        end.
                    bUsed.isUsed = true.
                    detaillevel(bFiles.info).
        /*                for each bUsed where bUsed.isUsed = true:                */
        /*                    display bUsed.info format "x(30)" with size 50 by 10.*/
        /*                end.                                                     */
                end.
            end.
    end.
    
    do transaction:
        for each bUsed where bUsed.isUsed = false no-lock no-error:
            create unusedB.
            unused.compileUnit = bUsed.compileUnit.
            unused.fileName = bUsed.fileName.
            unused.type = bUsed.type.
            unused.system = bused.system.
            unused.info = bused.info.
        end.
    end.
end.

function isUsing return integer (systemName as character):
    for each files where files.system = vSystem and files.type = "INCLUDE":
    if available files
        then do:
            find first ttUsed where ttUsed.info = files.info no-error.
            if not available ttUsed
                then do:
                    create ttUsed.
                    ttUsed.compileUnit = files.compileUnit.
                    ttUsed.fileName = files.fileName.
                    ttUsed.type = Files.type.
                    ttUsed.system = Files.system.
                    ttUsed.info = Files.info.
                    ttUsed.isUsed = false.
                end.
        end.
    end.

    for each files where files.system = vSystem and files.type = "COMPILE":
        if available files
            then do:
                create ttUsed.
                ttUsed.compileUnit = files.compileUnit.
                ttUsed.fileName = files.fileName.
                ttUsed.type = Files.type.
                ttUsed.system = Files.system.
                ttUsed.info = Files.info.
                ttUsed.isUsed = false.
            end.
    end.
end.    
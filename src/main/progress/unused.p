{ttUsed.i}

//define input parameter vSystem as character no-undo.
define variable vSystem as character no-undo.
define variable vName as character no-undo.
define variable vCompileUnit as character no-undo.
define variable i as integer no-undo.
define variable vEntryPoints as character format "x(100)" no-undo extent 100.
define variable skaitliukas as integer no-undo.
define buffer bUsed for ttUsed.

/*------Funckiju apsibrëþimas-------*/
function detailLevel returns integer (compileUnitNext1 as character) forward.
function isUsing return integer (systemName1 as character) forward.

vSystem = os-getenv("FELIX-SYSTEM-NAME").

find first systems where systems.systemName = vSystem no-lock.

if length(systems.entryPoints) = r-index(systems.entryPoints,",") then
    systems.entryPoints = substring(systems.entryPoints,1,length(systems.entryPoints) - 1).

isUsing(vSystem).

repeat i = 1 to num-entries(systems.entryPoints, ",").
    vEntryPoints = entry(i,systems.entryPoints,",").
    detailLevel(vEntryPoints[i]).
end.   

    
    for each bUsed where bUsed.isUsed = false exclusive-lock:
        do:
            create unused.
            unused.compileUnit = bUsed.compileUnit.
            unused.fileName = bUsed.fileName.
            unused.type = bUsed.type.
            unused.system = bused.system.
            unused.info = bused.info.
        end.
    end.

function detailLevel returns integer (compileUnitNext as character):
    define buffer bfiles for files.
    define buffer ufiles for files.    
    
    do:
        find first ufiles where ufiles.compileUnit matches ("*" + compileUnitNext + "*") and
            ufiles.system = vSystem and
            (ufiles.type = "COMPILE" or 
            ufiles.type = "INCLUDE") no-lock no-error.
        if available ufiles 
            then do: 
                vName = entry(num-entries(ufiles.info,"/"),ufiles.info,"/").
                vCompileUnit = ufiles.info. //cia tikrinamo dalyko info laukas
        
                for each bfiles where 
                    (bFiles.info <> vCompileUnit and
                    bFiles.compileUnit = ufiles.compileUnit and 
                    bFiles.system = vSystem and
                    ((index(bfiles.info, ".p") <> 0) or 
                    (index(bfiles.info, ".cls") <> 0) or 
                    (index(bfiles.info, ".i") <> 0))) no-lock:      
                    
                    find bUsed where bUsed.info = bFiles.info no-lock no-error.
                    if not available bUsed
                        then do:
                            create bUsed.
                            bUsed.compileUnit = bfiles.info.
                            bUsed.fileName = bfiles.fileName.
                            bUsed.type = bFiles.type.
                            bUsed.system = bFiles.system.
                            bUsed.info = "***PROGRESS SYSTEM FILE***".
                            bUsed.isUsed = true.
                        end.
                    bUsed.isUsed = true.
                    
                    detaillevel(bFiles.info).
/*                        for each bUsed where bUsed.isUsed = true:                                  */
/*                            display bUsed.compileUnit bUsed.info format "x(30)" with size 50 by 10.*/
/*                        end.                                                                       */
                end.
            end.
    end.
end.

function isUsing return integer (systemName as character):
    for each files where files.system = vSystem and files.type = "INCLUDE" no-lock:
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
                    i = i + 1.
                end.
        end.
    end.

    for each files where files.system = vSystem and files.type = "COMPILE" no-lock:
        if available files
            then do:
                create ttUsed.
                ttUsed.compileUnit = files.compileUnit.
                ttUsed.fileName = files.fileName.
                ttUsed.type = Files.type.
                ttUsed.system = Files.system.
                ttUsed.info = Files.info.
                ttUsed.isUsed = false.
                i = i + 1.
            end.
    end.
    
    display i.
end.    

  
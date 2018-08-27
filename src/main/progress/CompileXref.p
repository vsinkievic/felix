
define variable cFileStream as character no-undo.
define input parameter cInputDir as character no-undo format "x(200)".
define input parameter cOutputDir as character no-undo format "x(200)".
define variable cPath as character no-undo format "x(200)". 
define variable isum as integer init 0.
define variable cFileType as character no-undo.
define variable cInputPath as character no-undo format "x(200)".

function compileFiles returns integer (cInputDirectory as character) forward.
function addPropath return integer (cInputDirectory as character) forward.

//----------------------------------- Main BLock -----------------------------------------
cInputPath = cInputDir.
input from os-dir(cInputDir).
output to value(cOutputDir + os-getenv("FELIX-SYSTEM-NAME") + ".txt").
compileFiles (cInputDir).
input close.
output close.
os-command value("type nul > " + os-getenv("TEMP") + "\compile.done").

//----------------------------------- Functions -----------------------------------------
                                                    
function compileFiles returns integer (cInputDirectory as character):
    
    import cFileStream.
    import cFileStream.
    
    repeat:
        
        import cFileStream.
        file-info:file-name = cInputDirectory + "\" + cFileStream.
        cFileType = substring (cFileStream, r-index(cFileStream, ".") + 1).
        
        
        if index (file-info:file-type, "D") > 0
        
        then do:
            
            input from os-dir(cInputDirectory + "\" + cFileStream).
            compileFiles (cInputDirectory + "\" + cFileStream).
            input close.
            
        end.       
            
        else if cFileType = "p" or cFileType = "cls" or cFileType = "w"
        then do:
            do on error undo, throw:
                cPath = cInputDirectory + "\" + cFileStream.
                cPath = replace (cPath, "\", "_").
                cPath = replace (cPath, " ", "").
                cPath = substring(cPath, 4).
                
                
                compile value(cInputDirectory + "\" + cFileStream) save xref value(cOutputDir + subst("&1.xref", cPath)).
                            isum = isum + 1.
                
                catch eSystemError as Progress.Lang.Error :
                    
                    os-command value("del " + cOutputDir + subst("&1.xref", cPath)).
                    message replace(cInputDirectory + "\" + cFileStream, cInputPath,"").
                    message eSystemError:GetMessage(1).
                    undo, next.
                end catch.
            end.
        end.
        
    end.
    return isum.
end function.





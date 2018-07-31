
define variable cFileStream as character no-undo.
define input parameter cImputDir as character no-undo format "x(200)".
define input parameter cOutputDir as character no-undo format "x(200)".
define variable cPath as character no-undo format "x(200)". 
define variable isum as integer init 0.
define variable cFileType as character no-undo.

function compileFiles returns integer (cImputDirectory as character) forward.
function addPropath return integer (cImputDirectory as character) forward.

//----------------------------------- Main BLock -----------------------------------------

input from os-dir(cImputDir).
output to value(cOutputDir + "errorfiles.txt").
message "-----------FAILAI KURIE NESIKOMPILIUOJA!-----------".
compileFiles (cImputDir).

input close.
output close.
os-command value("type nul > " + os-getenv("TEMP") + "\compile.done").

//----------------------------------- Functions -----------------------------------------
                                                    
function compileFiles returns integer (cImputDirectory as character):
    
    import cFileStream.
    import cFileStream.
    
    repeat:
        
        import cFileStream.
        file-info:file-name = cImputDirectory + "\" + cFileStream.
        cFileType = substring (cFileStream, r-index(cFileStream, ".") + 1).
        
        
        if index (file-info:file-type, "D") > 0
        
        then do:
            
            input from os-dir(cImputDirectory + "\" + cFileStream).
            compileFiles (cImputDirectory + "\" + cFileStream).
            input close.
            
        end.       
            
        else if cFileType = "p" or cFileType = "cls" or cFileType = "i" or cFileType = "w"
        then do:
            do on error undo, throw:
            cPath = cImputDirectory + "\" + cFileStream.
            cPath = replace (cPath, "\", "_").
            cPath = replace (cPath, " ", "").
            cPath = substring(cPath, 4).
            
            
            compile value(cImputDirectory + "\" + cFileStream) save xref value(cOutputDir + subst("&1.xref", cPath)).
                        isum = isum + 1.
            
            catch eSystemError as Progress.Lang.Error :
                os-command value("del " + cOutputDir + subst("&1.xref", cPath)).
                message cImputDirectory + "\" + cFileStream.
                
                undo, next.
            end catch.
            end.
        end.
        
    end.
    
    return isum.
end function.





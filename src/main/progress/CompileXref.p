
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cImputDir AS CHARACTER NO-UNDO FORMAT "x(200)".
DEFINE INPUT PARAMETER cOutputDir AS CHARACTER NO-UNDO FORMAT "x(200)".
define variable cPath AS CHARACTER NO-UNDO FORMAT "x(200)". 
DEFINE VARIABLE isum AS INTEGER INIT 0.
DEFINE VARIABLE cFileType AS CHARACTER NO-UNDO.

FUNCTION compileFiles RETURNS INTEGER (cImputDirectory AS CHARACTER) FORWARD.

//----------------------------------- Main BLock -----------------------------------------

INPUT FROM OS-DIR(cImputDir).

compileFiles (cImputDir).

INPUT CLOSE.

os-command value("type nul > " + os-getenv("TEMP") + "\compile.done").

//----------------------------------- Functions -----------------------------------------
                                                    
FUNCTION compileFiles RETURNS INTEGER (cImputDirectory AS CHARACTER):
    
    IMPORT cFileStream.
    IMPORT cFileStream.
    
    REPEAT:
        
        IMPORT cFileStream.
        FILE-INFO:FILE-NAME = cImputDirectory + "\" + cFileStream.
        cFileType = SUBSTRING (cFileStream, r-index(cFileStream, ".") + 1).
        
        
        IF INDEX (FILE-INFO:FILE-TYPE, "D") > 0
        
        THEN DO:
            
            INPUT FROM OS-DIR(cImputDirectory + "\" + cFileStream).
            compileFiles (cImputDirectory + "\" + cFileStream).
            INPUT CLOSE.
            
        END.       
            
        ELSE IF cFileType = "p" OR cFileType = "cls" OR cFileType = "i" OR cFileType = "w"
        THEN DO:
            
            cPath = cImputDirectory + "\" + cFileStream.
            cPath = Replace (cPath, "\", "_").
            cPath = Replace (cPath, " ", "").
            cPath = substring(cPath, 4).
            compile value(cImputDir + "\" + cFileStream) save xref value(cOutputDir + subst("&1.xref", cPath)).
            isum = isum + 1.

        END.
        
    END.
    
    RETURN isum.
END FUNCTION.



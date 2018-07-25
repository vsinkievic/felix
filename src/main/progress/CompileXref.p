
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER cImputDir AS CHARACTER NO-UNDO FORMAT "x(200)".
DEFINE INPUT PARAMETER cOutputDir AS CHARACTER NO-UNDO FORMAT "x(200)".
define variable cPath AS CHARACTER NO-UNDO FORMAT "x(200)". 
DEFINE VARIABLE isum AS INTEGER INIT 0.
DEFINE VARIABLE cFileType AS CHARACTER NO-UNDO.

FUNCTION compileFiles RETURNS INTEGER (cImputDirectory AS CHARACTER) FORWARD.
FUNCTION getAfterPoint RETURNS CHARACTER (INPUT cInputString AS CHARACTER) FORWARD.

//----------------------------------- Main BLock -----------------------------------------

OUTPUT TO ttt.txt.    
//display cImputDir cOutputDir
//with width 400.
message "type nul > " + os-getenv("TEMP") + "\compile.done".
INPUT FROM OS-DIR(cImputDir).

compileFiles (cImputDir).

INPUT CLOSE.
OUTPUT CLOSE.

os-command value("type nul > " + os-getenv("TEMP") + "\compile.done").


//----------------------------------- Functions -----------------------------------------
                                                    
FUNCTION compileFiles RETURNS INTEGER (cImputDirectory AS CHARACTER):
    
    IMPORT cFileStream.
    IMPORT cFileStream.
    
    REPEAT:
        
        IMPORT cFileStream.
        FILE-INFO:FILE-NAME = cImputDirectory + "\" + cFileStream.
        cFileType = getAfterPoint (cFileStream).
        
        
        IF INDEX (FILE-INFO:FILE-TYPE, "D") > 0
        
        THEN DO:
            
            INPUT FROM OS-DIR(cImputDirectory + "\" + cFileStream).
            compileFiles (cImputDirectory + "\" + cFileStream).
            INPUT CLOSE.
            
        END.       
            
        ELSE IF cFileType = "p" OR cFileType = "cls" OR cFileType = "i" OR cFileType = "w"
        THEN DO:
            MESSAGE cFileStream.
            cPath = cImputDirectory + "\" + cFileStream.
            
            cPath = Replace (cPath, "\", "_").
            cPath = substring(cPath, 4).
            MESSAGE cImputDir + "\" + cFileStream.
            message cOutputDir + subst("&1.xref", cPath).
            compile value(cImputDir + "\" + cFileStream) save xref value(cOutputDir + subst("&1.xref", cPath)).
            isum = isum + 1.

        END.
        
    END.
    
    RETURN isum.
END FUNCTION.

FUNCTION getAfterPoint RETURNS CHARACTER (INPUT cInputString AS CHARACTER):
    
    DEFINE VARIABLE itemp AS INTEGER INIT 0.
    
    itemp = NUM-ENTRIES (cInputString, ".").
    
    DO WHILE itemp > 0:
        
        itemp = itemp - 1.
        cInputString = SUBSTRING (cInputString, INDEX (cInputString, ".") + 1).
    END.
    
    RETURN cInputString.
    
END FUNCTION.

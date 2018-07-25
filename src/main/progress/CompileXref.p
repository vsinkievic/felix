
DEFINE VARIABLE cFileStream AS CHARACTER NO-UNDO.
DEFINE VARIABLE cDir AS CHARACTER NO-UNDO FORMAT "x(200)" INIT "C:\Users\Studentas1\Progress\Developer Studio 4.3.1\workspace".
DEFINE VARIABLE cPath AS CHARACTER NO-UNDO FORMAT "x(200)".
DEFINE VARIABLE isum AS INTEGER INIT 0.
DEFINE VARIABLE cFileType AS CHARACTER NO-UNDO.

FUNCTION compileFiles RETURNS INTEGER (cDirectory AS CHARACTER) FORWARD.
FUNCTION getAfterPoint RETURNS CHARACTER (INPUT cInputString AS CHARACTER) FORWARD.

//----------------------------------- Main BLock -----------------------------------------

OUTPUT TO ttt.txt.    
INPUT FROM OS-DIR(cDir).

DISPLAY "total files" compileFiles (cDir).

INPUT CLOSE.
OUTPUT CLOSE.

//----------------------------------- Functions -----------------------------------------
                                                    
FUNCTION compileFiles RETURNS INTEGER (cDirectory AS CHARACTER):
    
    IMPORT cFileStream.
    IMPORT cFileStream.
    
    REPEAT:
        
        IMPORT cFileStream.
        FILE-INFO:FILE-NAME = cDirectory + "\" + cFileStream.
        cFileType = getAfterPoint (cFileStream).
        //MESSAGE cFIleType.
        
        IF INDEX (FILE-INFO:FILE-TYPE, "D") > 0
        
        THEN DO:
            
            INPUT FROM OS-DIR(cDirectory + "\" + cFileStream).
            compileFiles (cDirectory + "\" + cFileStream).
            INPUT CLOSE.
            
        END.       
            
        ELSE IF cFileType = "p" OR cFileType = "cls" OR cFileType = "i" OR cFileType = "w"
        THEN DO:

            //MESSAGE cFileStream.
            cPath = cDirectory + cFileStream.
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

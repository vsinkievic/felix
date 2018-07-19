//RUN THIS TO IMPORT XREF FILE INFO TO DB

//output to "output.txt".

define variable cFileStream as character no-undo.
define variable cDir as character no-undo init 'C:\Users\Studentas1\Progress\Developer Studio 4.3.1\workspace\felix\lib\xref\'.
define variable cPath as character no-undo.

for each files:
    delete files.
end.

INPUT FROM OS-DIR(cDir).

REPEAT:       
    IMPORT cFileStream.
        if cFileStream matches "*.xref" 
        then do:
            cPath = cDir + cFileStream.
            run dataExport.p(input cPath).
        end.
END.

INPUT CLOSE.
//output close.
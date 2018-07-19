//RUN THIS TO IMPORT XREF FILE INFO TO DB

//output to "output.txt".

define variable cFileStream as character no-undo.
define variable cDir as character no-undo format "x(200)" init "Input your .xref file directory".
define variable cPath as character no-undo.

update cDir label ".xref directory path" help "example: C:\Users\Studentas1\xref\" with size 100 by 5.


for each files:
    delete files.
end.

INPUT FROM OS-DIR(cDir).

REPEAT:       
    IMPORT cFileStream.
        if cFileStream matches "*.xref" 
        then do:
            cPath = cDir + cFileStream.
            run importXref.p(input cPath).
        end.
END.

INPUT CLOSE.

//output close.
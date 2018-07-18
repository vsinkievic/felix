//RUN THIS TO IMPORT XREF FILE INFO TO DB

//output to "output.txt".

define variable cFileStream as character no-undo.
define variable cDir as character no-undo init 'C:\mokymai\Felix\xref\'.
define variable path as character no-undo.

for each files:
    delete files.
end.

INPUT FROM OS-DIR(cDir).

REPEAT:       
    IMPORT cFileStream.
        if cFileStream matches "*.xref" then do:
            path = cDir + cFileStream.
            run reader.p(input path).
    end.
END.

INPUT CLOSE.
//output close.
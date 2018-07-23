//RUN THIS TO IMPORT XREF FILE INFO TO DB

define variable cFileStream as character no-undo.
define variable cDir as character no-undo format "x(200)" init "Input your .xref file directory".
define variable cPath as character no-undo.

update cDir label ".xref directory path" help "example: C:\Users\Studentas1\xref\" with size 100 by 5.


for each files use-index systemIndex:
    delete files.
end.

input from os-dir(cDir).

repeat:       
    import cFileStream.
        if cFileStream matches "*.xref" 
        then do:
            cPath = cDir + cFileStream.
            run importXref.p(input cPath).
        end.
end.

input close.
//RUN THIS TO IMPORT XREF FILE INFO TO DB

define variable cFileStream as character no-undo.
define variable cPath as character no-undo format "x(200)" init "Input your .xref file directory".
define input parameter cDir as character no-undo.
define input parameter cSystem as character no-undo.

/*update cDir label ".xref directory path" help "example: C:\Users\Studentas1\xref\"*/
/*    cSystem label "System name"                                                   */
/*    with 1 col size 100 by 5.                                                     */
    


for each files:
    delete files.
end.

input from os-dir(cDir).

repeat:       
    import cFileStream.
        if cFileStream matches "*.xref" 
        then do:
            cPath = cDir + cFileStream.
            run importXref.p(input cPath, input cSystem).
        end.
end.

input close.
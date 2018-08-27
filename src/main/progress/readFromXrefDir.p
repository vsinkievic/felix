//RUN THIS TO IMPORT XREF FILE INFO TO DB

define variable cFileStream as character no-undo format "x(200)".
define variable cPath as character no-undo format "x(200)".
define input parameter cDir as character no-undo format "x(200)".
define input parameter cSystem as character no-undo format "x(200)".

    
//---Triggeriu propath pridejimas
define variable ppropath as character no-undo.
find systems where systems.systemName = cSystem.
ppropath = systems.systemLocation + "\felix\src\main\progress\Triggers".
propath = substring(propath,3).
propath =  ".," + ppropath + "," + propath.
message propath.

//----DB duomenu trynimas
for each files where files.system = cSystem:
    delete files.
end.

for each fieldDB where fieldDB.system = cSystem:
    delete fieldDB.
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
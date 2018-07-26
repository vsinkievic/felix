{ttCompilerParams.i}
    
temp-table ttSystemInfo:read-json("file",os-getenv("TEMP") + "\FelixSystemInfo.json","empty").
find ttSystemInfo.    

//-----Pridedamas propath
define variable ppropath as character no-undo.
ppropath = program-name(1).
file-info:file-name = ppropath.
ppropath = file-info:full-pathname.
ppropath = substring(ppropath,1,r-index(ppropath,"\") - 1).
propath =  ".," + ppropath + "," + ttSystemInfo.flocalSourcePath + substring(propath,2).

//----Kvieèiama procedûra xref skaitymui
run readFromXrefDir.p(input os-getenv("TEMP") + "\" + ttSystemInfo.fsystemName + "\",input ttSystemInfo.fsystemName).

os-delete value(os-getenv("JSON-LOCATION")).
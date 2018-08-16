{ttUnused.i}

//define input parameter vSystem as character no-undo.
define variable vSystem as character no-undo.
define variable vName as character no-undo.
define variable vCompileUnit as character no-undo.
define variable i as integer no-undo.
define variable vEntryPoints as character format "x(50)" no-undo extent 100.

define buffer bFiles for files.

vSystem = "indigo".

find first systems where systems.systemName = vSystem. //susirandam is kur imti entryPoints
repeat i = 1 to num-entries(systems.entryPoints, ","). //kartos visà veiksmà tiek, kiek bus entryPointø
vEntryPoints = entry(i,systems.entryPoints,","). // ima is eiles entryPointus, veliau juos kisam i for each

    find first files where files.compileUnit = vEntryPoints[i].
    for each files no-lock where
            files.system = vSystem and
            files.type = "COMPILE":                 //atsirenka kiekviena faila, prie kurio priskirta ta sistema ir kuris turi tipa "compile".
        vName = entry(num-entries(files.info,"/"),files.info,"/").    //karpom files.info, is jo pasiemam pavadinima, kuris bus naudojamas kaip kitas compUnit ir rodo kad jis naudojamas to
        vCompileUnit = files.info.    //dabartinis compileUnit susirasom visa files.info turini
        if index(files.info, ".p") <> 0  //pradedam filtravima, cia surasineja tik proceduras
        then do:     
            vName = replace(vName,".p","").   //sutvarkom ivesta varda, kad ji visur butu galima kisti.
            find first bFiles where
                       (bFiles.compileUnit = vCompileUnit and //bufferyje esanti compileUnit turi atitikti dabartini compileUnita
                       bFiles.info <> vCompileUnit) or //bufferyje esantis info laukas turi skirtis nuo menamo compileUnit.
                       (bFiles.system = vSystem and //bufferyje esanti sistema, turi atitikti ivestos sistemos pavadinima ir
                       bFiles.type <> "COMPILE" and //tipas turi nebuti "COMPILE" ir
                       (bFiles.info matches ("*/" + vName + "~~.p") or //cia vyksta pavadinimo isskyrimas is bufferyje esancio info lauko plain teksto arba
                       bFiles.info = vName or //bufferyje esantis info laukas gali pilnai atitikti ivesta pavadinima (cia kai ivedama viskas pavadinimas arba
                       bFiles.info matches("*/" + vName) or //dar vienas isskyrimo variantas
                       bFiles.info matches (vName + "~~.p"))) no-lock no-error. //kai ivedama formatu "procedura.p"
                       
            if not available bFiles
            then do:
                create unused.
                unused.type = "PROCEDURE".
                unused.compileUnit = files.compileUnit.
                unused.system = vSystem.
                unused.fileName = vName.
            end.
        end.
        else if index(files.info, ".cls") <> 0
        then do:
            vName = replace(vName,".cls","").
            find first bFiles where
                       (bFiles.info <> vCompileUnit and
                       bFiles.compileUnit = vCompileUnit) or
                       (bFiles.system = vSystem and
                       bFiles.type <> "COMPILE" and
                       (bFiles.info matches("*~~." + vName) or
                       bFiles.info = vName or
                       bFiles.info matches ("*~~." + vName + ":*"))) no-lock no-error.
            if not available bFiles
            then do:
                create unused.
                unused.type = "CLASS".
                unused.compileUnit = files.compileUnit.
                unused.system = vSystem.
                unused.fileName = vName.
            end.
        end.
        else if index(files.info, ".i") <> 0
        then do:
            find first bFiles where
                       (bFiles.info <> vCompileUnit and
                       bFiles.compileUnit = vCompileUnit) or
                       (bFiles.system = vSystem and
                       bFiles.type <> "COMPILE" and
                       (bFiles.info matches ("*/" + vName) or
                       bFiles.info = vName)) no-lock no-error.
            if not available bFiles
            then do:
                create unused.
                unused.type = "INCLUDE".
                unused.compileUnit = files.compileUnit.
                unused.system = vSystem.
                unused.fileName = vName.
            end.
        end.
    end.
end.
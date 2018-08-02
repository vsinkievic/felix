define input parameter cPth as character no-undo.
define variable cDelDb as character no-undo.
define variable cLoadSt as character no-undo.
define variable cDelBi as character no-undo.
define variable cTrunBi as character no-undo.
define variable cFileStream as character no-undo format "x(200)".
define variable cError as character no-undo.

define output parameter cDbName as character no-undo init ?.
define variable cStName as character no-undo.
define variable cDfName as character no-undo.

define variable iStCounter as integer no-undo init 0.
define variable iDfCounter as integer no-undo init 0.
define variable iDbCounter as integer no-undo init 0.

cError = os-getenv("TEMP") + "\DBerrors.txt".

if substr(cPth, length(cPth)) <> "\" and index(cPth, "\") <> 0
then do:
    cPth = cPth + "\".
end.  
else if substr(cPth, length(cPth)) <> "/" and index(cPth, "/") <> 0
then do:
    cPth = cPth + "/".
end. 

input from os-dir(cPth).

repeat:
    import cFileStream.
        if cFileStream matches "*.db" 
        then do:
            cDbName = replace(cFileStream, ".db", "").
            iDbCounter = iDbCounter + 1.
        end.
        else if cFileStream matches "*.df" 
        then do:
            cDfName = cFileStream.
            iDfCounter = iDfCounter + 1.
        end.
        else if cFileStream matches "*.st" 
        then do:
            cStName = cFileStream.
            iStCounter = iStCounter + 1.
        end.
end.

input close.

creation:
do transaction:
    if cStName <> ""
    then do:    
        if replace(cStName, ".st", "") <> replace(cDfName, ".df", "")
        then do:
            output to value(cError).
            display ".st ir .df failø pavadinimai nesutampa" format "x(50)" with width 100.
            output close.
            undo creation, leave creation.
        end.
    end.
    if (iStCounter > 1) or (iDbCounter > 1) or (iDfCounter > 1)
    then do:
        output to value(cError).
        display "Yra daugiau nei po vienà .db arba .st arba .df failà" format "x(50)" with width 100.
        output close.
        undo creation, leave creation.
    end.
    
    
    cDelDb = "%DLC%\bin\prodel " + cPth + cDbName.
    cLoadSt = "%DLC%\bin\prostrct add " + cPth + replace(cStName, ".st", "") + " " + cPth + cStName.
    
    if cDbName = ?
    then do:
        cDbName = replace(cDfName, ".df", "").
        message "creating db" view-as alert-box.
        run createDbInternal.
    end.
    else do:
        cDbName = replace(cDfName, ".df", "").
        message "resetting db" view-as alert-box.
        os-command value(cDelDb).
        run createDbInternal.
    end.
    
    procedure createDbInternal:
        cDelBi = "%DLC%\bin\prostrct remove " + cPth + cDbName + " bi".
        cTrunBi = "%DLC%\bin\proutil " + cPth + cDbName + ".db" + " -C truncate bi".
      //  os-command value("C:\Progress\OpenEdge\bin\procopy C:\Progress\OpenEdge\empty.db C:\Users\Studentas1\Desktop\Testavimas\Alfredas.db").
      message cPth cDbName view-as alert-box.
        create database cPth + cDbName from "EMPTY".
        if cStName <> ""
        then do:
            os-command silent value(cTrunBi).
            os-command silent value(cDelBi).
            os-command silent value(cLoadSt).
        end.   
        connect value(cPth + cDbName) -1.
        create alias DICTDB for database value(cDbName).
        run prodict/load_df.p (cPth + cDfName).
        disconnect value(cDbName).
    end.
end.
//disconnect value(cDbName).
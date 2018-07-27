/*define input parameter pth as character no-undo.    */
/*define input parameter sysName as character no-undo.*/

define variable pth as character no-undo init "C:\mokymai\Felix\CrDbTest\".
define variable sysName as character no-undo init "indigo".
define variable cDelDb as character no-undo.

cDelDb = "%DLC%/bin/prodel " + pth + sysName.

/*find systems where systems.systemName = sysName.*/
/*if available systems                            */
/*then do:                                        */
/*    pth = systems.localSourcePath.              */
/*end.                                            */

connect value(pth + sysName + ".db") -1 no-error.
if error-status:error
then do:
    message "creating db" view-as alert-box.
    run createDbInternal.
    disconnect value(sysName).
end.
else do:
    disconnect value(sysName).
    os-command value(cDelDb).
    run createDbInternal.
    disconnect value(sysName).
end.

//Nepabaigta, neþinom kaip iðtrinti db

procedure createDbInternal:
    create database pth + sysName + ".db" from "EMPTY".
    connect value(pth + sysName + ".db") -1.
    create alias DICTDB for database value(sysName).
    run prodict/load_df.p (pth + sysName + ".df").
end.


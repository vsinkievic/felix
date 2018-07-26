define input parameter pth as character no-undo.
define input parameter sysName as character no-undo.

/*find systems where systems.systemName = sysName.*/
/*if available systems                            */
/*then do:                                        */
/*    pth = systems.localSourcePath.              */
/*end.                                            */

connect value(pth + sysName + ".db") -1 no-error.
if error-status:error
then do:
    //message "creating db" view-as alert-box.
    create database pth + sysName + ".db" from "EMPTY".
    connect value(pth + sysName + ".db") -1.
    create alias DICTDB for database value(sysName).
    run prodict/load_df.p (pth + sysName + ".df").
    //disconnect value(sysName).
end.
/*else do:                                                */
/*    //message "disconnecting from db" view-as alert-box.*/
/*    disconnect value(sysName).                          */
/*end.                                                    */

//Nepabaigta, neþinom kaip iðtrinti db


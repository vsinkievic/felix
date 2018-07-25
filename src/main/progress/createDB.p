define variable pth as character no-undo init "C:\mokymai\Felix\CrDbTest\".
define variable flxPth as character no-undo init "C:\Users\Studentas1\Progress\Developer Studio 4.3.1\workspace\felix\db\".
define variable sysName as character no-undo init "indigo".

find systems where systems.systemName = sysName.
if available systems
then do:
    pth = systems.localSourcePath.
end.

connect value(pth + sysName + ".db") -1 no-error.
if error-status:error
then do:
    message "creating db" view-as alert-box.
    create database pth + sysName + ".db" from "EMPTY".
    connect value(pth + sysName + ".db") -1.
    CREATE ALIAS DICTDB FOR DATABASE value(sysName).
    run prodict/load_df.p ("C:\mokymai\Felix\CrDbTest\" + "FelixDB.df").
    disconnect value(sysName).
end.
else do:
    message "disconnecting from db" view-as alert-box.
    disconnect value(sysName).
end.

//Nepabaigta, neþinom kaip iðtrinti db


define variable flxPth as character no-undo init "C:\Users\Studentas1\Progress\Developer Studio 4.3.1\workspace\felix\db\".
define variable flxName as character no-undo.
/**/
run createDB.p(input flxPth, output flxName).
define input parameter cName as character.
define input parameter iType as integer.
define variable i as integer.

define temp-table ttOutput like FelixDB.files.

define output parameter table for ttOutput.


// ðitas for each turi veikti jeigu veiktø DB:

/*for each FelixDB.files where files.fileName = cName no-lock:*/
/*    create ttOutput.                                        */
/*        ttOutput.sourceName = cName.                        */
/*        ttOutput.sourcePath = files.sourcePath.             */
/*        ttOutput.line = files.line.                         */
/*end.                                                        */
    
repeat i = 1 to 5:
    create ttOutput.
        ttOutput.sourceName = cName.
        ttOutput.sourcePath = "somepath/" + string(i) + "/somedirectory/".
        ttOutput.line = i.
end.
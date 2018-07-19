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
/*        ttOutput.type = files.type.                         */
/*        ttOutput.info = files.info                          */
/*end.                                                        */
    
repeat i = 1 to 50:
    create ttOutput.
        ttOutput.sourceName = "someprocedure.p".
        ttOutput.sourcePath = "somepath/" + string(i) + "/somedirectory/".
        ttOutput.line = random (1, 300).
        ttOutput.type = "RUN".
        ttOutput.info = "core/businessErr.i &id='LON0140' &p1=loan.migdt".
end.
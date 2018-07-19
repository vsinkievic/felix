define temp-table ttOutput like files.

define input parameter cName as character.
define output parameter table for ttOutput.



for each FelixDB.files no-lock where
                 files.type = "RUN" and
                 (files.info matches("*" + cName) or
                 files.info matches("*" + cName + ".p")):
/*     find first ttOutput where files.compileUnit = ttOutput.compileUnit no-error.*/
/*     if not available ttOutput                                                   */
/*     then do:                                                                    */
         create ttOutput.
         ttOutput.compileUnit = files.compileUnit.
         ttOutput.fileName = files.fileName.
         ttOutput.sourceName = files.sourceName.
         ttOutput.sourcePath = files.sourcePath.
         ttOutput.type = files.type.
         ttOutput.line = files.line.
         ttOutput.info = files.info.
/*     end.*/
end.

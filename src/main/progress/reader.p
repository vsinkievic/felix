//DON'T RUN THIS

define variable source_name as character no-undo.
define variable file_name as character no-undo.
define variable line_number as character no-undo.
define variable xref_type as character no-undo.
define variable xref_information as character no-undo.
define variable i as integer no-undo.
define variable i2 as integer no-undo.
define input parameter path as character no-undo.

input from value(path).

        repeat:
            import delimiter " " source_name
                                 file_name
                                 line_number
                                 xref_type
                                 xref_information.

            if xref_type = "RUN" or xref_type = "NEW" or xref_type = "INCLUDE" then do:
                repeat i = 2 to num-entries(file_name, "/"):
                end.
                repeat i2 = 2 to num-entries(source_name, "/"):
                end.
                
                create files.
                    assign
                        files.fileName = entry(i - 1, file_name, "/")
                        files.sourceName = entry(i2 - 1, source_name, "/")
                        files.sourcePath = source_name
                        files.line = integer(line_number)
                        files.type = xref_type
                        files.info = xref_information.
                        
/*                display source_name //entry(i - 1, source_name, "/") format "x(200)" */
/*                        entry(i - 1, file_name, "/") format "x(30)" label "file_name"*/
/*                        line_number                                                  */
/*                        xref_type                                                    */
/*                        right-trim(xref_information, ",INPUT") format "x(100)"       */
/*                        with width 210.                                              */
            end.
        end.

input close.
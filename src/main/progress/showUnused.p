{ttUnused.i}

define input parameter vSystem as character no-undo.
define output parameter table for ttUnused.

for each unused where unused.system = vSystem:
        create ttUnused.
        ttUnused.compileUnit = unused.compileUnit.
        ttUnused.name = unused.fileName.
        ttUnused.type = unused.type.
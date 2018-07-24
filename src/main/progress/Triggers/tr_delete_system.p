TRIGGER PROCEDURE FOR DELETE OF systems.

for each files where files.system = systems.systemName:
    delete files.
end.

for each fieldDB where fieldDB.system = systems.systemName:
    delete fieldDB.
end.
function val = get(fb, propName)
%GET

flds = {'mode', 'filename', 'path', 'headeropen', 'header', 'headersize', 'filesize', 'binary'};
id = find( strcmp(flds, propName) );
if ~isempty(id)
    val = fb.(flds{id});
else
    error('No such property.')
end
    

function val = get(fb, propName)
%GET get oject properties
%
%  Syntax
%
%      value = get(f, property)
%
%  Description
%
%    Valid properties for mwlfilebase objects are:
%    'mode', 'filename', 'path', 'header', 'headersize', 'filesize',
%    'format'
%

%  Copyright 2005-2006 Fabian Kloosterman


flds = {'mode', 'filename', 'path', 'header', 'headersize', 'filesize', 'format'};

id = find( strcmp(flds, propName) );

if ~isempty(id)
    val = fb.(flds{id});
else
    error('No such property.')
end
    

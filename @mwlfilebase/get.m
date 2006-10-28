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


flds = {'mode', 'filename', 'path', 'header', 'headersize', 'format'};

id = find( strcmp(flds, propName) );

if ~isempty(id)
    val = fb.(flds{id});
elseif strcmp( 'filesize', propName )
    if ismember( fb.mode, {'read', 'append'} )
        fid = fopen(fullfile(fb.path, fb.filename), 'rb');
        fseek(fid, 0, 'eof');
        val = ftell(fid);
        fclose(fid);
    else
        val = 0;
    end
else
  try
    val = getParam(fb.header, propName);
    val = val{1};
  catch
    error('No such property.')
  end
end
    

function f = reopen(fb)
%REOPEN reopen file
%
%  Syntax
%
%      f = reopen( f )
%

%  Copyright 2005-2006 Fabian Kloosterman

if ismember(fb.mode, {'write', 'overwrite'})
    error('File is in ' fb.mode ' mode. Cannot reopen.')
end

if nargout<1
    warning('Please supply output variable. File not reopened.')
    return  
end

cl = class(fb);

eval(['f = ' cl '( ''' fullfile(fb.path, fb.filename) ''', ''' fb.mode  ''' );']);

function f = reopen(fb)
%REOPEN

if fb.headeropen
    error('File is in write mode. Cannot reopen.')
end

if nargout<1
    warning('Please supply output variable. File not reopened.')
    return  
end


cl = class(fb);

eval(['f = ' cl '( ''' fullfile(fb.path, fb.filename) ''', ''r'' );']);

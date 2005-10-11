function f = reopen(fb)
%REOPEN

% $Id: reopen.m,v 1.1 2005/10/09 20:38:05 fabian Exp $

if strcmp(fb.mode, 'w')
    error('File is in write mode. Cannot reopen.')
end

if nargout<1
    warning('Please supply output variable. File not closed.')
    return  
end


cl = class(fb);

eval(['f = ' cl '( ''' fullfile(fb.path, fb.filename) ''', ''r'' );']);


% $Log: reopen.m,v $
% Revision 1.1  2005/10/09 20:38:05  fabian
% *** empty log message ***
%

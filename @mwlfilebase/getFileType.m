function ft = getFileType(fb)
%GETFILETYPE

% $Id: getFileType.m,v 1.1 2005/10/09 20:36:39 fabian Exp $

if fb.headeropen
    error('Header is still open')
end

ft = headerType(fb.header(1));


% $Log: getFileType.m,v $
% Revision 1.1  2005/10/09 20:36:39  fabian
% *** empty log message ***
%

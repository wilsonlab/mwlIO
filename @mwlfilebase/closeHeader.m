function fb = closeHeader(fb)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 20:34:59 fabian Exp $

if ~strcmp(fb.mode, 'w')
    error('File is not in write mode')
end

if ~fb.headeropen
    error('Header is already closed')
end

hdr = get(fb, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

if fb.binary
    sh = setParam(sh, 'File type', 'Binary');
else
    sh = setParam(sh, 'File type', 'Ascii');
end

hdr(1) = sh;

fb = set(fb, 'header', hdr);

fwrite(fb.fid, dumpHeader(fb.header));

fb.headersize = ftell(fb.fid);
fb.headeropen = false;


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 20:34:59  fabian
% *** empty log message ***
%

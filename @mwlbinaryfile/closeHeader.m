function bf = closeHeader(bf)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 19:51:16 fabian Exp $

hdr = get(bf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File type', 'Binary');

hdr(1) = sh;

bf = set(bf, 'header', hdr);

bf.mwlfilebase = closeHeader(bf.mwlfilebase);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 19:51:16  fabian
% *** empty log message ***
%

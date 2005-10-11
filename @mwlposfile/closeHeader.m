function pf = closeHeader(pf)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 20:44:59 fabian Exp $

hdr = get(pf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'rawpos');

hdr(1) = sh;

pf = set(pf, 'header', hdr);

pf.mwlrecordfilebase = closeHeader(pf.mwlrecordfilebase);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 20:44:59  fabian
% *** empty log message ***
%

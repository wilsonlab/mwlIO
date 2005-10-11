function pf = closeHeader(pf)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 19:53:18 fabian Exp $

hdr = get(pf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'diode');
sh = setParam(sh, 'Extraction type', 'extended dual diode position');

hdr(1) = sh;

pf = set(pf, 'header', hdr);

pf.mwlfixedrecordfile = closeHeader(pf.mwlfixedrecordfile);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 19:53:18  fabian
% *** empty log message ***
%

function ef = closeHeader(ef)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 19:55:04 fabian Exp $

hdr = get(ef, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'eeg');

hdr(1) = sh;

ef = set(ef, 'header', hdr);

ef.mwlfixedrecordfile = closeHeader(ef.mwlfixedrecordfile);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 19:55:04  fabian
% *** empty log message ***
%

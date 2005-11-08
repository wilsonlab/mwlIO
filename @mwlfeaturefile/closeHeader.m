function ff = closeHeader(ff)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 20:33:38 fabian Exp $

hdr = get(ff, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'feature');

hdr(1) = sh;

ff = set(ff, 'header', hdr);

ff.mwlfixedrecordfile = closeHeader(ff.mwlfixedrecordfile);

% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 20:33:38  fabian
% *** empty log message ***
%

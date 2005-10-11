function val = dumpHeader(h)
%DUMPHEADER

% $Id: dumpHeader.m,v 1.1 2005/10/08 04:24:19 fabian Exp $

val = '';

if length(h.subheaders) == 0
    return
end

val = '%%BEGINHEADER\n';

for sh=1:size(h.subheaders,1)
    val = [val dumpHeader(h.subheaders(sh))];
end

val = [val '%%ENDHEADER\n'];


% $Log: dumpHeader.m,v $
% Revision 1.1  2005/10/08 04:24:19  fabian
% *** empty log message ***
%

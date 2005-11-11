function val = dumpHeader(h)
%DUMPHEADER

% $Id: dumpHeader.m,v 1.1 2005/10/08 04:24:19 fabian Exp $

val = '';

if length(h.subheaders) == 0
    return
end

val = sprintf('%%%%BEGINHEADER\n');

for sh=1:length(h.subheaders)
    val = [val dumpHeader(h.subheaders(sh))];
end

val = [val sprintf('%%%%ENDHEADER\n')];


% $Log: dumpHeader.m,v $
% Revision 1.1  2005/10/08 04:24:19  fabian
% *** empty log message ***
%

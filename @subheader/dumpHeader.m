function val = dumpHeader(sh)
%DUMPHEADER

% $Id: dumpHeader.m,v 1.1 2005/10/09 20:54:18 fabian Exp $

val = '';

if size(sh.parms, 1) == 0
    return
end

for p=1:size(sh.parms,1)
    
    if strcmp(sh.parms{p,1}, '')
        %comment
        val = [ val sprintf('%% %s\n', sh.parms{p, 2}) ];
    else
        %parameter
        val = [ val sprintf('%% %s:\t%s\n', sh.parms{p,1}, sh.parms{p,2}) ];
    end
    
end

val = [val sprintf('%%\n')];


% $Log: dumpHeader.m,v $
% Revision 1.1  2005/10/09 20:54:18  fabian
% *** empty log message ***
%

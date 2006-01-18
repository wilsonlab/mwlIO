function val = dumpHeader(sh)
%DUMPHEADER dump subheader contents as string
%
%  Syntax
%
%      s = dumpHeader( h )
%

%  Copyright 2005-2006 Fabian Kloosterman

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
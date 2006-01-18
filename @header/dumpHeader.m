function val = dumpHeader(h)
%DUMPHEADER dump header contents as string
%
%  Syntax
%
%      s = dumpHeader( h )
%


%  Copyright 2005-2006 Fabian Kloosterman

val = '';

if length(h.subheaders) == 0
    return
end

val = sprintf('%%%%BEGINHEADER\n');

for sh=1:length(h.subheaders)
    val = [val dumpHeader(h.subheaders(sh))];
end

val = [val sprintf('%%%%ENDHEADER\n')];



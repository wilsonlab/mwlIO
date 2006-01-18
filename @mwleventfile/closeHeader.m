function ef = closeHeader(ef)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  Syntax
%
%      f = closeHeader( f )
%

%  Copyright 2005-2006 Fabian Kloosterman

hdr = get(ef, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'event');
sh = setParam(sh, 'Extraction type', 'event strings');

hdr(1) = sh;

ef = set(ef, 'header', hdr);

ef.mwlfixedrecordfile = closeHeader(ef.mwlfixedrecordfile);

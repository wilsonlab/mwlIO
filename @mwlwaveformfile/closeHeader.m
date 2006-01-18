function wf = closeHeader(wf)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  Syntax
%
%      f = closeHeader( f )
%

%  Copyright 2005-2006 Fabian Kloosterman

hdr = get(wf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'waveform');

hdr(1) = sh;

wf = set(wf, 'header', hdr);

wf.mwlfixedrecordfile = closeHeader(wf.mwlfixedrecordfile);

function rfb = closeHeader(rfb)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  Syntax
%
%      f = closeHeader( f )
%

%  Copyright 2005-2006 Fabian Kloosterman


if nargout~=1
    warning('It is safer to provide an output argument. Aborted.')
    return;
end

fldstr = print( rfb.fields );

hdr = get(rfb, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh = hdr(1);
end

sh = setParam(sh, 'Fields', fldstr);

hdr(1) = sh;

rfb = set(rfb, 'header', hdr);

rfb.mwlfilebase = closeHeader(rfb.mwlfilebase);

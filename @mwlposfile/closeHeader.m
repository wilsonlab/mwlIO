function pf = closeHeader(pf)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  Syntax
%
%      f = closeHeader( f )
%

%  Copyright 2005-2006 Fabian Kloosterman

hdr = get(pf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'rawpos');

hdr(1) = sh;

pf = set(pf, 'header', hdr);

pf.mwlrecordfilebase = closeHeader(pf.mwlrecordfilebase);

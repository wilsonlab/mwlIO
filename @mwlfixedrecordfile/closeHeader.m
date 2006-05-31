function f = closeHeader(f)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  Syntax
%
%      f = closeHeader( f )
%

%  Copyright 2005-2006 Fabian Kloosterman

hdr = get(f, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

fileformat = getParam( sh, 'File Format' );
if isempty(fileformat)
    sh = setParam(sh, 'File Format', 'fixedrecord');
end

hdr(1) = sh;

f = set(f, 'header', hdr);

f.mwlrecordfilebase = closeHeader(f.mwlrecordfilebase);
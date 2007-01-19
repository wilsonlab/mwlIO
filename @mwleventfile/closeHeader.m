function ef = closeHeader(ef)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  f=CLOSEHEADER(f) closes the header for further modifications, writes
%  the header to disk and reopens the file in append mode.
%
%  Example
%    f = mwleventfile('test.dat', 'write')
%    f = closeHeader(f);
%
%  See also HEADER
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

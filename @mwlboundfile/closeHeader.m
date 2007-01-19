function bf = closeHeader(bf)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  f=CLOSEHEADER(f) closes the header for further modifications, writes
%  the header to disk and reopens the file in append mode.
%
%  Example
%    f = mwlboundfile('test.dat', 'write')
%    f = closeHeader(f);
%
%  See also HEADER
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargout~=1
    warning('mwlboundfile:closeHeader:invalidOutput', 'It is safer to provide an output argument. Aborted.')
    return;
end

hdr = get(bf, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'clbound');

hdr(1) = sh;

bf = set(bf, 'header', hdr);

bf.mwlfilebase = closeHeader(bf.mwlfilebase);
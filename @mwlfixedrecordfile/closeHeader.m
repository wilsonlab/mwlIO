function f = closeHeader(f)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%  f=CLOSEHEADER(f) closes the header for further modifications, writes
%  the header to disk and reopens the file in append mode.
%
%  Example
%    f = mwlfixedrecordfile('test.dat', 'write')
%    f = closeHeader(f);
%
%  See also HEADER
%

%  Copyright 2005-2008 Fabian Kloosterman

hdr = get(f, 'header');

fileformat = hdr('File Format');
if isempty(fileformat)
  hdr('File Format') = 'fixedrecord';
end

f = set(f, 'header', hdr);

f.mwlrecordfilebase = closeHeader(f.mwlrecordfilebase);

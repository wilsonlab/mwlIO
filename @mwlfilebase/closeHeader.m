function fb = closeHeader(fb)
%CLOSEHEADER write header to disk and reopen file in append mode
%
%   Syntax
%   f = closeHeader( f )
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman


if ismember(fb.mode, {'read', 'append'})
    return
end

hdr = get(fb, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

if ismember(fb.format, 'binary')
    sh = setParam(sh, 'File type', 'Binary');
else
    sh = setParam(sh, 'File type', 'Ascii');
end

hdr(1) = sh;

fb = set(fb, 'header', hdr);

fid = fopen(fullfile(fb), 'w');

if fid<1
    error('Cannot open file for writing')
end

fwrite(fid, dumpHeader(fb.header));

fb.headersize = ftell(fid);
fb.mode = 'append';

fclose(fid);

fb = reopen(fb);
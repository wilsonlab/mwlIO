function fb = closeHeader(fb)
%CLOSEHEADER

if ~strcmp(fb.mode, 'w') || ~fb.headeropen
    return
end

fid = fopen(fullfile(fb), 'w');
if fid<1
    error('Cannot open file for writing')
end

hdr = get(fb, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

if fb.binary
    sh = setParam(sh, 'File type', 'Binary');
else
    sh = setParam(sh, 'File type', 'Ascii');
end

hdr(1) = sh;

fb = set(fb, 'header', hdr);

fid = fopen(fullfile(fb), 'w');

fwrite(fid, dumpHeader(fb.header));

fb.headersize = ftell(fid);
fb.headeropen = false;

fclose(fid);

fb = reopen(fb);
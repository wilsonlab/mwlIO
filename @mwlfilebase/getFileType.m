function ft = getFileType(fb)
%GETFILETYPE

if fb.headeropen
    error('Header is still open')
end

ft = headerType(fb.header(1));

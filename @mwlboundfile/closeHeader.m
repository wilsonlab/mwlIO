function bf = closeHeader(bf)
%CLOSEHEADER

if nargout~=1
    warning('It is safer to provide an output argument. Aborted.')
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
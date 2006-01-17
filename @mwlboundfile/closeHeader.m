function bf = closeHeader(bf)
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
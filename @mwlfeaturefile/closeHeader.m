function ff = closeHeader(ff)
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

hdr = get(ff, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'feature');

hdr(1) = sh;

ff = set(ff, 'header', hdr);

ff.mwlfixedrecordfile = closeHeader(ff.mwlfixedrecordfile);

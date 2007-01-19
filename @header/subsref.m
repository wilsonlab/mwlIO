function b = subsref(h,s)
%SUBSREF subscripted indexing
%
%  val=SUBSREF(h, subs) allow subscripted indexing to retrieve subheaders
%  from a header.
%
%  Example
%    hdr = header();
%    sh = subheader();
%    sh = setParam(sh, 'test', 1);
%    hdr(1) = sh;
%    sh = hdr(1);
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '()'
    ind = s.subs{:};
    b = h.subheaders(ind);
otherwise
   error('header:subsref:invalidIndexing', 'Invalid indexing')
end


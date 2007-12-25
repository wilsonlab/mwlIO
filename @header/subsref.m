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

switch s(1).type
case '()'
 ind = s(1).subs{:};
 b = h.subheaders(ind);
 if numel(s)>1
   switch s(2).type
    case '.'
     b = getParam(b,s(2).subs);
    otherwise
     error('header:subsref:invalidIndexing', 'Invalid indexing')
   end
 end
otherwise
   error('header:subsref:invalidIndexing', 'Invalid indexing')
end


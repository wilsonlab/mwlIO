function b = subsref(h,s)
%SUBSREF subscripted indexing
%
%  val=SUBSREF(h, subs) allow subscripted indexing to retrieve subheaders
%  and parameters from a header.
%
%  Example
%    sh = newheader('parm1', 1, 'parameter two', 2);
%    hdr = header( sh );
%    hdr(1) %retrieves first subheader
%    p = hdr(1).parm1; %retrieves parameter from subheader 1
%    p = hdr(:).('parameter two'); %retrieves parameter from all subheaders
%

%  Copyright 2005-2006 Fabian Kloosterman


switch s(1).type
case '()'
 ind = s(1).subs{:};
 b = header(h.subheaders(ind));
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


function h = subsasgn(h,s,b)
%SUBSASGN subscripted assignment
%
%  h=SUBSASGN(h, subs, val) subscripted assignment to add (or replace)
%  subheaders to a header object.
%
%  Example
%    sh = subheader();
%    sh = setParam( sh, 'Test', 1)
%    h = header();
%    h(1) = sh;
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s(1).type
case '()'
 ind = s(1).subs{:};
 if numel(s)>1
   switch s(2).type
    case '.'
     h.subheaders(ind) = setParam(h.subheaders(ind),s(2).subs,b);
    otherwise
     error('header:subsasgn:invalidIndexing', 'Invalid indexing')
   end
 else
   if ~isa(b, 'subheader')
     error('header:subsasgn:invalidAssignment', 'Not a subheader')
   end
   if isempty(h.subheaders)
     h.subheaders = b;
   else
     h.subheaders(ind) = b;
   end
 end
 otherwise
  error('header:subsasgn:invalidAssignment', 'Invalid assignment')
end

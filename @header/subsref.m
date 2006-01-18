function b = subsref(h,s)
%SUBSREF subscripted indexing
%
%  Syntax
%
%      header( n )
%
%  Description
%
%    This method will allow subscripted indexing to retrieve subheaders in a
%    header
%


%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '()'
    ind = s.subs{:};
    b = h.subheaders(ind);
otherwise
   error('Specify value for x as p(x)')
end


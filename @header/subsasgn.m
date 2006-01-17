function h = subsasgn(h,s,b)
%SUBSASGN subscripted assignment
%
%   Syntax
%   header( n ) = subheader
%
%   This method will allow subscripted assignment to add subheaders to
%   a header
%
%   Examples
%   sh = subheader();
%   sh = setParam( sh, 'Test', 1)
%   h = header();
%   h(1) = sh;
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '()'
    ind = s.subs{:};
    if ~isa(b, 'subheader')
        error('Not a subheader')
    end
    if length(h.subheaders)==0
        h.subheaders = b;
    else
        h.subheaders(ind) = b;
    end
otherwise
   error('Specify value for x as p(x)')
end

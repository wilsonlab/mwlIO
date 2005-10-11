function h = subsasgn(h,s,b)
% SUBSASGN

% $Id: subsasgn.m,v 1.1 2005/10/08 04:26:58 fabian Exp $

switch s.type
case '()'
    ind = s.subs{:};
    if ~isa(b, 'subheader')
        error('Not a subheader')
    end
    h.subheaders(ind) = b;
otherwise
   error('Specify value for x as p(x)')
end


% $Log: subsasgn.m,v $
% Revision 1.1  2005/10/08 04:26:58  fabian
% *** empty log message ***
%

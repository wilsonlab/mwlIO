function b = subsref(h,s)
% SUBSREF 

% $Id: subsref.m,v 1.1 2005/10/08 04:27:27 fabian Exp $

switch s.type
case '()'
    ind = s.subs{:};
    b = h.subheaders(ind);
otherwise
   error('Specify value for x as p(x)')
end


% $Log: subsref.m,v $
% Revision 1.1  2005/10/08 04:27:27  fabian
% *** empty log message ***
%

function fb = subsasgn(fb,s, b)
% SUBSREF 

% $Id: subsasgn.m,v 1.1 2005/10/09 20:38:43 fabian Exp $

switch s.type
case '.'
    if strcmp(s.subs, 'header')
        if ~fb.headeropen
            error('Header is already closed.')       
        elseif ~isa(b, 'header')
            error('Not a header.')
        else
            fb.header = b;
        end
    elseif strcmp(s.subs, 'binary')
        if ~fb.headeropen
            error('Header is already closed.')
        elseif (b~=0 & b~=1)
            error('Invalid value for binary parameter')
        else
            fb.binary = b;
        end        
    else
        error('Cannot assign to this property.')
    end
end


% $Log: subsasgn.m,v $
% Revision 1.1  2005/10/09 20:38:43  fabian
% *** empty log message ***
%

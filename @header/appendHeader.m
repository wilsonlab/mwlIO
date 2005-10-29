function h = appendHeader(h, sh)
%ADDHEADER

% $Id: appendHeader.m,v 1.1 2005/10/08 04:22:15 fabian Exp $

if ~isa(sh, 'subheader')
    error('Can only append subheaders')
end

if length(h.subheaders)==0
    h.subheaders=sh;
else
    h.subheaders(end+1) = sh;
end


% $Log: appendHeader.m,v $
% Revision 1.1  2005/10/08 04:22:15  fabian
% *** empty log message ***
%

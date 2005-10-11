function sh = subheader(varargin)
%SUBHEADER

% $Id: subheader.m,v 1.1 2005/10/09 20:56:08 fabian Exp $

if nargin==0
    sh.parms = cell(0,2);
    sh = class(sh, 'subheader');
elseif isa(varargin{1}, 'subheader')
    sh = varargin{1};
else
    error 'subheader constructor takes no arguments'
end


% $Log: subheader.m,v $
% Revision 1.1  2005/10/09 20:56:08  fabian
% *** empty log message ***
%

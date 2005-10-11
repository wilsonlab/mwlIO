function h = header(varargin)
%HEADER constructor

% $Id: header.m,v 1.1 2005/10/08 04:20:38 fabian Exp $

if nargin==0
    h.subheaders = [];
    h = class(h, 'header');
elseif isa(varargin{1}, 'header')
    h = varargin{1};
else
    error 'header constructor takes no arguments'
end

% $Log: header.m,v $
% Revision 1.1  2005/10/08 04:20:38  fabian
% *** empty log message ***
%

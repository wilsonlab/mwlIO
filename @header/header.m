function h = header(varargin)
%HEADER constructor
%
%   Syntax
%   h = header()      default constructor
%   h = header( h )   copy constructor
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    h.subheaders = [];
    h = class(h, 'header');
elseif isa(varargin{1}, 'header')
    h = varargin{1};
else
    error 'header constructor takes no arguments'
end

function sh = subheader(varargin)
%SUBHEADER constructor
%
%   Syntax
%   h = subheader()     default constructor
%   h = subheader( h )  copy constructor
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman


if nargin==0
    sh.parms = cell(0,2);
    sh = class(sh, 'subheader');
elseif isa(varargin{1}, 'subheader')
    sh = varargin{1};
else
    error 'subheader constructor takes no arguments'
end




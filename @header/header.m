function h = header(varargin)
%HEADER constructor
%
%  Syntax
%
%      h = header()      default constructor
%      h = header( h )   copy constructor
%


%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    h.subheaders = [];
    h = class(h, 'header');
elseif isa(varargin{1}, 'header')
    h = varargin{1};
elseif isa(varargin{1}, 'subheader')
    h.subheaders = varargin{1};
    h = class(h, 'header');
end

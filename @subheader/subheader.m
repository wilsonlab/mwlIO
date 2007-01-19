function sh = subheader(varargin)
%SUBHEADER subheader constructor
%
%  sh=SUBHEADER default constructor, creates a new empty subheader
%  object.
%
%  sh=SUBHEADER(sh) copy constructor
%


%  Copyright 2005-2006 Fabian Kloosterman


if nargin==0
    sh.parms = cell(0,2);
    sh = class(sh, 'subheader');
elseif isa(varargin{1}, 'subheader')
    sh = varargin{1};
else
    error('subheader:subheader:invalidArguments', ...
          'subheader constructor takes no arguments')
end




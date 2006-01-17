function display(fb, c)
%DISPLAY display object information
%
%   Syntax
%   display(h [,hidetitle])
%
%   This method will display object information. An optional title will
%   be displayed if hidetitle = 0 (default)
%
%   Example
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- FEATURE FILE OBJECT --'])
end

display(fb.mwlfixedrecordfile, 1)

function display(bf, c)
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
    disp(['-- BOUNDS FILE OBJECT --'])
end

display(get(bf, 'mwlfilebase'), 1)
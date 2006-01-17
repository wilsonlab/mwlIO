function display(fb, c)
%DISPLAY show record file information
%
%   Syntax
%   display( field )
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- RECORD FILE OBJECT --'])
end

display(get(fb, 'mwlfilebase'), 1)

display(fb.fields)

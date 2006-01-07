function display(bf, c)
%DISPLAY

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- BOUNDS FILE OBJECT --'])
end

display(get(bf, 'mwlfilebase'), 1)
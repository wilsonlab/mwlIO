function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:33:58 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- FEATURE FILE OBJECT --'])
end

display(fb.mwlfixedrecordfile, 1)


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:33:58  fabian
% *** empty log message ***
%

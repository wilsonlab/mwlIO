function display(sh, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:53:59 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- SUBHEADER OBJECT --'])
end

np = size(sh.parms, 1);

fieldnames = strjust(str2mat(sh.parms{:,1}), 'left');
fieldvalues = strjust(str2mat(sh.parms{:,2}), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', np, 1);

disp( [repmat('  ', np, 1) fieldnames fieldvalues])


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:53:59  fabian
% *** empty log message ***
%

function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:40:33 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- FIXED RECORD FILE OBJECT --'])
end

display(get(fb, 'mwlrecordfilebase'), 1)


fieldnames = {'record size', 'n records'};
fieldvalues = {num2str(fb.recordsize), num2str(fb.nrecords)};

nf = length(fieldnames);

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldvalues = strjust(str2mat(fieldvalues), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', nf, 1);

disp( [ repmat('  ', nf, 1) fieldnames fieldvalues])


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:40:33  fabian
% *** empty log message ***
%

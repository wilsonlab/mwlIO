function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:30:52 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- EVENT FILE OBJECT --'])
end

display(fb.mwlfixedrecordfile, 1)


fieldnames = {'string size'};
fieldvalues = {num2str(fb.string_size)};

nf = length(fieldnames);

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldvalues = strjust(str2mat(fieldvalues), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', nf, 1);

disp( [ repmat('  ', nf, 1) fieldnames fieldvalues])


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:30:52  fabian
% *** empty log message ***
%

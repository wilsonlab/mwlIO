function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.2 2005/10/11 19:02:33 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- RECORD FILE OBJECT --'])
end

display(get(fb, 'mwlfilebase'), 1)

fieldnames = {'fields'};

%prepare fields cell
nf = size(fb.fields,1);
fieldstring = char();
for f=1:nf
    fieldstring(f,:) = sprintf('    %10s %7s %6d %6d', fb.fields{f,:});
end

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', 1, 1);

disp( [ repmat('  ', 1, 1) fieldnames])
disp( [ sprintf('    %10s %7s %6s %6s', 'name', 'type', 'bytes', 'size') ])
disp( [ fieldstring ] );


% $Log: display.m,v $
% Revision 1.2  2005/10/11 19:02:33  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:48:22  fabian
% *** empty log message ***
%

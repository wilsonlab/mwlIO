function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:35:39 fabian Exp $

yn_map = {'no', 'yes'};

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- FILE OBJECT --'])
end

if strcmp(fb.mode, 'r')
    filemode = 'read';
else
    filemode = 'write';
end

if isbinary(fb)
    filetype = 'binary';
else
    filetype = 'ascii';
end

fieldnames = {'file name', 'file path', 'file mode', 'file type', 'header open', 'file size', 'header size'};
fieldvalues = {fb.filename, fb.path, filemode, filetype, yn_map{fb.headeropen+1}, [num2str(fb.filesize) ' bytes'], [num2str(fb.headersize) ' bytes']};

nf = length(fieldnames);

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldvalues = strjust(str2mat(fieldvalues), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', nf, 1);

disp( [ repmat('  ', nf, 1) fieldnames fieldvalues])


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:35:39  fabian
% *** empty log message ***
%

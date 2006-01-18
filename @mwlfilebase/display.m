function display(fb, c)
%DISPLAY display object information
%
%  Syntax
%
%      display(h [,hidetitle])
%
%  Description
%
%    This method will display object information. An optional title will
%    be displayed if hidetitle = 0 (default)
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- FILE OBJECT --'])
end

fieldnames = {'file name', 'file path', 'file mode', 'file type', 'file size', 'header size'};
fieldvalues = {fb.filename, fb.path, fb.mode, fb.format, [num2str(fb.filesize) ' bytes'], [num2str(fb.headersize) ' bytes']};

nf = length(fieldnames);

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldvalues = strjust(str2mat(fieldvalues), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', nf, 1);

disp( [ repmat('  ', nf, 1) fieldnames fieldvalues])


function display(sh, c)
%DISPLAY show information about subheader
%
%  Syntax
%
%      display(h [,hidetitle])
%
%  Description
%
%    This method will display the subheader contents. An optional title will
%    be displayed if hidetitle = 0 (default)
%

%  Copyright 2005-2006 Fabian Kloosterman

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


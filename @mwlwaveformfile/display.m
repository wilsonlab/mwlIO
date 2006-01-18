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
    disp(['-- WAVEFORM FILE OBJECT --'])
end

display(fb.mwlfixedrecordfile, 1)


fieldnames = {'n samples', 'n channels'};
fieldvalues = {num2str(fb.nsamples), num2str(fb.nchannels)};

nf = length(fieldnames);

fieldnames = strjust(str2mat(fieldnames), 'left');
fieldvalues = strjust(str2mat(fieldvalues), 'left');
fieldnames(:, end+1:end+3) = repmat(' : ', nf, 1);

disp( [ repmat('  ', nf, 1) fieldnames fieldvalues])

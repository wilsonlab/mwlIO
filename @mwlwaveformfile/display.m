function display(fb, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/09 20:51:26 fabian Exp $

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


% $Log: display.m,v $
% Revision 1.1  2005/10/09 20:51:26  fabian
% *** empty log message ***
%

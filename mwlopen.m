function f = mwlopen(filename)
%MWLOPEN

% $Id: mwlopen.m,v 1.1 2005/10/09 21:05:11 fabian Exp $

f = mwlfilebase(filename);
filetype = getFileType(f);
f = close(f);

switch filetype
    case 'diode'
        f = mwldiodefile(filename);
    case 'eeg'
        f = mwleegfile(filename);
    case 'event'
        f = mwleventfile(filename);
    case 'feature'
        f = mwlfeaturefile(filename);
    case 'fixedrecord'
        f = mwlfixedrecordfile(filename);
    case 'rawpos'
        f = mwlposfile(filename);
    case 'waveform'
        f = mwlwaveformfile(filename);
    case 'cluster'
        f = mwlfixedrecordfile(filename);
    case 'clbound'
        f = mwlboundfile(filename);
    otherwise
        error('Unsupported filetype')
end


% $Log: mwlopen.m,v $
% Revision 1.1  2005/10/09 21:05:11  fabian
% *** empty log message ***
%

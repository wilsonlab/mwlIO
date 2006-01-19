function f = mwlopen(filename)
%MWLOPEN open a mwl-type file
%
%  Syntax
%
%      f = mwlopen(filename)
%

%  Copyright 2005-2006 Fabian Kloosterman

f = mwlfilebase(filename);
filetype = getFileType(f);

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

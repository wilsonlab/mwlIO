function wf = setFields(wf)
%SETFIELDS create fields for new waveform file
%
%  Syntax
%
%      f = setFields( f, fields )
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = mwlField({'timestamp', 'waveform'}, {'long', 'short'}, [1 wf.nchannels*wf.nsamples]);

wf.mwlfixedrecordfile = setFields(wf.mwlfixedrecordfile, fields);

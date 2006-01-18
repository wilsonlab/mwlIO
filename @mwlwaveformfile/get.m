function val = get(wf, propName)
%GET get oject properties
%
%  Syntax
%
%      value = get(f, property)
%
%  Description
%
%    Valid properties for mwlwaveformfile objects are (in addition to
%    those inherited from mwlfixedrecordfile): 'nsamples', 'nchannels'
%
%  See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = wf.(propName);
catch
    val = get(wf.mwlfixedrecordfile, propName);
end

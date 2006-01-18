function data = load(wf, flds, i)
%LOAD load waveform data
%
%  Syntax
%
%      data = load( f, load_fields [, indices] )
%
%  Description
%
%    This method allows you to load data from multiple fields, as specified
%    by the cell array load_fields. The parameter indices is an optional
%    vector of record indices. Random access is possible.
%

%  Copyright 2005-2006 Fabian Kloosterman

data = load(wf.mwlfixedrecordfile, flds, i);

if isfield(data, 'waveform')
    data.waveform = permute(reshape(data.waveform', wf.nchannels, wf.nsamples, size(data.waveform, 1)), [2 1 3]);
end

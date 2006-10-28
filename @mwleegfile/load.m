function data = load(ef, varargin)
%LOAD load eeg data
%
%  Syntax
%
%      data = load( f, load_fields [, indices] )
%
%  Description
%
%    This method allows you to load data from multiple fields, as specified
%    by the cell array load_fields. The parameter indices is an optional
%    vector of record indices. In eeg files each record contains a full
%    buffer of eeg data. Random access is possible.
%

%  Copyright 2005-2006 Fabian Kloosterman

data = load(ef.mwlfixedrecordfile, varargin{:});

if isfield(data, 'data')
    %data.data = reshape(data.data', ef.nchannels, size(data.data, 1)*ef.nsamples)';
    %data.data = permute( reshape( data.data, ef.nchannels, ef.nsamples, size(data.data, 2) ), [2 1 3]);
    data.data = reshape( data.data, ef.nchannels, ef.nsamples, size(data.data, 2) );
    %data.data = reshape( data.data, size(data.data,1), ef.nsamples, ef.nchannels );
end

function data = loadField(wf, field, varargin)
%LOADFIELD load data from single field
%
%  Syntax
%
%      data = loadField( f, field [, range] )
%
%  Description
%
%    This method loads data from a single field. Optionally a record range
%    can be specified.
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
    help(mfilename)
end

data = loadField(wf.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'waveform')
    %data = permute(reshape(data, size(data, 1), wf.nchannels, wf.nsamples), [3 2 1]);
    data.waveform = reshape( data.waveform, wf.nchannels, wf.nsamples, size(data.waveform, 2) );
end


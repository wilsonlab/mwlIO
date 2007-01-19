function data = loadField(wf, varargin)
%LOADFIELD load single field from waveform file
%
%  data=LOADFIELD(f, field) returns the data in the specified field from
%  all records in the file.
%
%  data=LOADFIELD(f, field, record_range) loads only the records in the
%  specified range. Record_range should be a two element vector with the
%  start and end record indices of the range.
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
    help(mfilename)
end

data = loadField(wf.mwlfixedrecordfile, varargin{:});

if strcmp(varargin{1}, 'waveform')
    data.waveform = reshape( data.waveform, wf.nchannels, wf.nsamples, size(data.waveform, 2) );
end

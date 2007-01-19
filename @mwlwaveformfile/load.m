function data = load(wf, varargin)
%LOAD load waveform data
%
%  data=LOAD(f) load all records from mwl waveform file. The returned
%  data is a structure with 'timestamp' and 'waveform' fields.
%
%  data=LOAD(f, fields) load only the fields specified. The fields
%  argument can be a string or a cell array of strings. If this argument
%  contains 'all', then all fields are loaded. Valid fields for an mwl
%  waveform file are: 'timestamp' and 'waveform'.
%
%  data=LOAD(f, fields, indices) load only the records listed in the
%  indices matrix. The first record has index 0. Random acess is
%  supported.
%
%  Example
%    f = mwlwaveformfile('test.tt');
%    data = load(f, {'timestamp'}, [0:10]);
%

%  Copyright 2005-2006 Fabian Kloosterman



data = load(wf.mwlfixedrecordfile, varargin{:});

if isfield(data, 'waveform')
    data.waveform = reshape( data.waveform, wf.nchannels, wf.nsamples, size(data.waveform, 2) );
end

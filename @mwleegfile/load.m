function data = load(ef, varargin)
%LOAD load eeg data
%
%  data=LOAD(f) load all records from mwl eeg file. The returned data is
%  a structure with 'timestamp' and 'data' fields.
%
%  data=LOAD(f, fields) load only the fields specified. The fields
%  argument can be a string or a cell array of strings. If this argument
%  contains 'all', then all fields are loaded. Valid fields for a mwl
%  eeg file are: 'timestamp' and 'data'.
%
%  data=LOAD(f, fields, indices) load only the records listed in the
%  indices vector. The first record has index 0. Random acess is
%  supported.
%
%  Example
%    f = mwleegfile('test.eeg');
%    data = load(f, {'timestamp'}, [0:10]);
%

%  Copyright 2005-2006 Fabian Kloosterman

data = load(ef.mwlfixedrecordfile, varargin{:});

if isfield(data, 'data')
    data.data = reshape( data.data, ef.nchannels, ef.nsamples, size(data.data, 2) );
end

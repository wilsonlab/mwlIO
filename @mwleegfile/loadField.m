function data = loadField(ef, field, varargin)
%LOADFIELD load data from single field
%
%   Syntax
%   data = loadField( f, field [, range] )
%
%   This method loads data from a single field. Optionally a record range
%   can be specified.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
    help(mfilename)
end

data = loadField(ef.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'data')
    data = permute(reshape(data', ef.nchannels, size(data, 1)*ef.nsamples), [2 1]);
end

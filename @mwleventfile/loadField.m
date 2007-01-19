function data = loadField(ef, varargin)
%LOADFIELD load single field from event file
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

data = loadField(ef.mwlfixedrecordfile, varargin{:});

if strcmp(varargin{1}, 'string')
    tmp = char(data.string);
    data.string = {};
    for i =1:size(tmp,1)
        data.string{i,1} = sprintf('%s', tmp(i,:));
    end
    data.string = deblank(data.string);    
end


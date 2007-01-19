function data = load(ef, flds, i)
%LOAD load event strings
%
%  data=LOAD(f) load all event strings from mwl event file. The returned
%  data is a structure with 'timestamp' and 'string' fields.
%
%  data=LOAD(f, fields) load only the fields specified. The fields
%  argument can be a string or a cell array of strings. If this argument
%  contains 'all', then all fields are loaded. Valid fields for an mwl
%  event file are: 'timestamp' and 'string'.
%
%  data=LOAD(f, fields, indices) load only the records listed in the
%  indices matrix. The first record has index 0. Random acess is
%  supported for binary files only.
%
%  Example
%    f = mwleventfile( 'events.dat' );
%    data = load(f, {'string'}, [0:5] );
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<3
    i = [];
end

if nargin<2
    flds = 'all';
end

data = load(ef.mwlfixedrecordfile, flds, i);

if isfield(data, 'string')
    tmp = char(data.string);
    data.string = {};
    for i =1:size(tmp,1)
        data.string{i,1} = sprintf('%s', tmp(i,:));
    end
    data.string = deblank(data.string);
end

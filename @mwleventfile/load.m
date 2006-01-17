function data = load(ef, flds, i)
%LOAD load event strings
%
%   Syntax
%   data = load( f, load_fields [, indices] )
%
%   This method allows you to load data from multiple fields, as specified
%   by the cell array load_fields. The parameter indices is an optional
%   vector of record indices.
%
%   Examples
%
%   See also 
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

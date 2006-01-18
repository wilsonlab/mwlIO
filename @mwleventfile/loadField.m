function data = loadField(ef, field, varargin)
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

data = loadField(ef.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'string')
    tmp = char(data.string);
    data.string = {};
    for i =1:size(tmp,1)
        data.string{i,1} = sprintf('%s', tmp(i,:));
    end
    data.string = deblank(data.string);    
end


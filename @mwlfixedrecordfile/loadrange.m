function data = loadrange(frf, fields, range, rangefield)
%LOADRANGE load data from mwl fixed record file
%
%   Syntax
%   data = loadrange( f [, fields [, range, range_field]] )
%
%   This method loads (part of) the data from a fixed record file f. The
%   fields parameter can be a string or cell array of strings indicating
%   which fields to load from the file. In case fields = 'all', then all
%   fields will be loaded (this is also the default if no fields parameter
%   is specified). The range parameter is a two-element vector specifying
%   the first and last record indices of the data range to load (default =
%   all records). The range_field parameter can be set to a field to use as
%   the source for the range, rather than record indices. This method only
%   reads binary files.
%   
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<3
    help(mfilename)
    return
end

if ismember(frf.format, {'ascii'})
    error('This function not implemented for ascii files');
end

if nargin<3 || isempty(range)
    range = [0 frf.nrecords-1 ];
elseif ~isnumeric(range) || numel(range)~=2
    error('Invalid range')
else
    range = double(range);
end

if nargin<4 || isempty(rangefield)
    %range = record indices
    data = load(frf, fields, range(1):range(2));
else
    %range = in field units
    flds = get(frf, 'fields');
    [dummy, fieldid] = ismember( rangefield, name(flds) );
    
    if isempty(fieldid) || fieldid==0
        error('Invalid range field')
    end
    
    fielddef = mex_fielddef( flds );
    
    idrange = findrecord( fullfile( get(frf, 'path'), get(frf, 'filename') ), range, fielddef(fieldid,:), get(frf, 'headersize'), get(frf, 'recordsize') );
    
    data = load(frf, fields, idrange(1):idrange(2));
end

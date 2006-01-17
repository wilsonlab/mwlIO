function data = loadrange(frf, loadflds, range, rangefield)
%LOADRANGE load data from mwl pos file
%
%   Syntax
%   data = loadrange( f [, fields [, range, range_field]] )
%
%   This method loads (part of) the data from raw position file f. The
%   fields parameter can be a string or cell array of strings indicating
%   which fields to load from the file. Valid fields are: 'nitems',
%   'frame', 'timestamp', 'target x', 'target y'. In case fields = 'all',
%   then all fields will be loaded (this is also the default if no fields
%   parameter is specified). The range parameter is a two-element vector
%   specifying the first and last record indices of the data range to load
%   (default = from current record to end of file). If range_field is set
%   to 'timestamp' then the range vector is in timestamps, rather than
%   record indices.
%   
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

fields = get(frf, 'fields');

if nargin<2 || isempty(loadflds)
    loadflds = name(fields);
elseif ischar(loadflds)
    loadflds = {loadflds};
elseif ~iscell(loadflds)
    error('Invalid fields')
end

if ismember( 'all', loadflds )
    loadflds = name(fields);
end

if nargin<3 || isempty(range)
    range = [frf.currentrecord frf.nrecords-1 ];
elseif ~isnumeric(range) || numel(range)~=2
    error('Invalid range')
else
    range = double(range);
end

[dummy, id] = ismember( loadflds, name(fields));
id( id==5 ) = 4; %because we are treating target x and target y fields as one pos field
fieldmask = sum( bitset(0, unique(id( id~=0 )) ) );

if fieldmask==0
    error('Invalid fields')
end

if nargin<4 || isempty(rangefield)
    %range = record indices
    frf = setCurrentRecord(frf, range(1));
    data = posloadrecordrange( fullfile(frf), frf.currentoffset, range(2)-range(1)+1, fieldmask);
else
    if ~ismember( rangefield, {'timestamp'} )
       error('Filtering only supported for timestamp field')
   end
    
   idrange = posfindtimerange(fullfile( frf ), get(frf, 'headersize'), range);
   frf = setCurrentRecord(frf, idrange(1));
   data = posloadrecordrange(fullfile( frf ), frf.currentoffset, idrange(2)-idrange(1)+1, fieldmask);

end


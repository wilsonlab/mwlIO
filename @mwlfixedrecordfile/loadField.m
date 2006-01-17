function data = loadField(frf, loadfield, range)
%LOADFIELD load data from single field
%
%   Syntax
%   data = loadField( f, field [, range] )
%
%   This method loads data from a single field. Optionally a record range
%   can be specified. This method reads both binary and ascii files.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
    help(mfilename)
    return
end

fields = get(frf, 'fields');
nfields = numel(fields);

if isempty(loadfield) || ~ischar(loadfield)
    error('Please specify a valid field')
else
    fieldid = ismember( loadfield, name(fields));
    if fieldid==0
        error('Unknown field')
    end
end

isbinary = ismember( frf.format, 'binary');

if nargin<3 || isempty(range)
    if isbinary
        range = [0 frf.nrecords-1 ];
    else
        range = [0 -1];
    end
elseif ~isnumeric(range) || numel(range)~=2
    error('Invalid range')
else
    range = double(range);
end


fid = fopen( fullfile( get(frf, 'path'), get(frf, 'filename') ), 'r' );

if fid == -1
    error('Cannot open file')
end

if ismember(frf.format, {'binary'})

    if range(2)==-1
        range(2) = frf.nrecords-1;
    elseif range(1)>range(2) || range(1)<0 || range(2)>frf.nrecords
        error('Invalid range')
    end
    
    offset = byteoffset( fields );
    offset = offset( fieldid );

    fseek(fid, get(frf, 'headersize') + offset + frf.recordsize * range(1), -1);

    data = fread( fid, fields{field, 4}*(endid-startid+1), [num2str(fields{field, 4}) '*' mwltypemapping(fields{field,2}, 'str2mat')], frf.recordsize - fields{field, 3}*fields{field, 4});
    data = fread( fid, length(fields(fieldid))*(diff(range)+1), [num2str(length(fields(fieldid))) '*' char(matcode(fields(fieldid)))], frf.recordsize - size(fields(fieldid)));
    
    data = reshape(data, length(fields(fieldid)), diff(range)+1)';
    
else %ascii file
    
    %create format string for textscan
    skip = ones(nfields,1);
    skip(fieldid)=0;
    fmt = formatstr(fields, skip)
    %fseek to header offset
    fseek(fid, get(frf, 'headersize'), -1);
    %do a textscan for (endid-startid+1) lines
    if range(2)==-1
        data = textscan(fid, fmt, 'headerLines', range(1));
    elseif range(1)<=range(2) && range(1)>=0
        data = textscan(fid, fmt, diff(range)+1, 'headerLines', range(1));
    else
        error('Invalid range')
    end
    
    %transform data to matrix if necessary
    data = cell2mat(data);
    
end

fclose(fid);

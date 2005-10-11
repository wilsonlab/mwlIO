function data = loadField(frf, field, startid, endid)
%LOADFIELD

% $Id: loadField.m,v 1.1 2005/10/09 20:41:26 fabian Exp $

if nargin<2
    help(mfilename)
    return
end

fields = get(frf, 'fields');
nfields = size(fields, 1);

if ischar(field)
    field = find(strcmp(fields, field));
    if isempty(field)
        error('Unknown field')
    end
end

if field<1 | field>nfields
    error('Invalid field number')
end

if isbinary(frf)
    nrecords = get(frf, 'nrecords');
else
    nrecords = 0;
end

if nargin<3
    %load all records
    startid = 0;
    endid = nrecords-1;
elseif nargin<4 
    endid = nrecords-1;
end

if ischar(startid) | ischar(endid) | ~isscalar(startid) | ~isscalar(endid)
    error('Incorrect types of startid and endid')
end

if (startid<0 | startid>endid | endid>nrecords-1) & endid~=-1
    error('Invalid indices')
end

fid = fopen( fullfile( get(frf, 'path'), get(frf, 'filename') ), 'r' );

if fid == -1
    error('Cannot open file')
end



if isbinary(frf)
   
    offset = 0;
    if field>1
        offset = sum([fields{1:field-1,3}]' .* [fields{1:field-1,4}]');
    end

    fseek(fid, get(frf, 'headersize') + offset + frf.recordsize * startid, -1);

    data = fread( fid, fields{field, 4}*(endid-startid+1), [num2str(fields{field, 4}) '*' mwltypemapping(fields{field,2}, 'str2mat')], frf.recordsize - fields{field, 3}*fields{field, 4});

    data = reshape(data, fields{field, 4}, endid-startid+1)';
    
else %ascii file
   
    %create format string for textscan
    skip = ones(nfields,1);
    skip(field)=0;
    fmt = fieldformatstr(fields, skip)
    %fseek to header offset
    fseek(fid, get(frf, 'headersize'), -1);
    %do a textscan for (endid-startid+1) lines
    if endid==-1
        data = textscan(fid, fmt, 'headerLines', startid);
    else
        data = textscan(fid, fmt, endid-startid+1, 'headerLines', startid);
    end
    %transform data to matrix if necessary
    data = cell2mat(data);
    
end

fclose(fid);


% $Log: loadField.m,v $
% Revision 1.1  2005/10/09 20:41:26  fabian
% *** empty log message ***
%

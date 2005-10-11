function data = load(frf, flds, i)
%LOAD

% $Id: load.m,v 1.1 2005/10/09 20:41:51 fabian Exp $

fields = get(frf, 'fields');
nfields = size(fields, 1);

if nargin<2 | isempty(flds)
    flds = 'all';
end

if ischar(flds)
    if strcmp(flds, 'all')
        flds = fields(:,1);
    else
        flds = {flds};
    end
elseif ~iscell(flds)
    error('Expecting cell array of field names')
end

if nargin<3 | isempty(i)
    i = -1;
end

if ~isa(i, 'double')
    try
        i = double(i);
    catch
        error('Invalid index array')
    end
end

if isbinary(frf)
    %check validity of field names
    %and create field definition array

    field_def = zeros(0,3);
    field_offsets = [0 cumsum([fields{1:end-1,3}].*[fields{1:end-1,4}])];
    for f = 1: length(flds)
        field_id = find(strcmp(fields(:,1), flds{f}));
        if isempty( field_id )
            error([ 'Invalid field name: ' flds{f}])
        else
            field_def(end+1, 1:3) = [field_offsets(field_id) mwltypemapping(fields{field_id,2}, 'str2mex') fields{field_id, 4}];
        end
    end

    if i==-1
        i = 0:frf.nrecords-1;
    end
    
    data = mwlio( fullfile(get(frf,'path'), get(frf, 'filename')), i, field_def, get(frf, 'headersize'), get(frf, 'recordsize'));

    %transpose arrays and construct names

    for f=1:length(flds)
        data{f} = data{f}';
        flds{f}(find(flds{f}==' ' | flds{f}=='-')) = '_';    
    end

    %create structure

    data = cell2struct(data, flds);
else %ascii
    
    if (max(diff(i)))>1
        error('Can only load contiguous blocks from Ascii file')
    else
        
        fid = fopen( fullfile( get(frf, 'path'), get(frf, 'filename') ), 'r' );

        if fid == -1
            error('Cannot open file')
        end
        
        skip = ones(nfields,1);
        for f = 1: length(flds)
            field_id = find(strcmp(fields(:,1), flds{f}));
            if isempty( field_id )
                error([ 'Invalid field name: ' flds{f}])
            else
                skip(field_id)=0;
            end
        end
        
        fmt = fieldformatstr(fields, skip);
        
        
        %fseek to header offset
        fseek(fid, get(frf, 'headersize'), -1);    
        if i==-1
            data = textscan(fid, fmt);
        else
            data = textscan(fid, fmt, length(i), 'headerLines', i(1));
        end
    
        flds = fields(find(skip==0),1);
        for f=1:length(flds)
            %data{f} = data{f}';
            flds{f}(find(flds{f}==' ' | flds{f}=='-')) = '_';    
        end
    
        %create structure
        data = cell2struct(data', flds);       
        
        fclose(fid);
    end
    
end


% $Log: load.m,v $
% Revision 1.1  2005/10/09 20:41:51  fabian
% *** empty log message ***
%

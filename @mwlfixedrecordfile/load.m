function data = load(frf, load_fields, i)
%LOAD load multiple fields from fixed record file
%
%  Syntax
%
%      data = load( f, load_fields [, indices] )
%
%  Description
%
%    This method allows you to load data from multiple fields, as specified
%    by the cell array load_fields. The parameter indices is an optional
%    vector of record indices. For binary files random access is supported;
%    for ascii files only a contiguous block of indices id supported. By
%    default the whole file is loaded.
%

%  Copyright 2005-2006 Fabian Kloosterman


fields = get(frf, 'fields');
nfields = numel(fields);

if nargin<2 || isempty(load_fields) || ismember( {'all'}, load_fields )
    load_fields = name(fields);
end

field_names = name(fields);
[dummy, field_id] = ismember( load_fields,field_names );

field_id = field_id( field_id~=0 );
load_fields = field_names( field_id );
    
for f=1:numel(field_id)
    load_fields{f}( (load_fields{f}==' ' | load_fields{f}=='-') ) = '_';    
end
    
if nargin<3 || isempty(i)
    i = -1; %load all records
end

if ~isa(i, 'double')
    try
        i = double(i);
    catch
        error('Invalid index array')
    end
end

if ismember(get(frf, 'format'), {'binary'})
    %check validity of field names
    %and create field definition array

    nrecords = get(frf, 'nrecords');
    
    field_def = mex_fielddef( fields );

    if i==-1
        i = 0:nrecords-1;
    end
    
    if any( i>=nrecords || i<0)
        error('Invalid index array (out of bounds)')
    end
    
    if any( fix(i) ~= i )
        error('Fractional indices not allowed')
    end 
    
    data = mwlio( fullfile(get(frf,'path'), get(frf, 'filename')), i, field_def(field_id,:), get(frf, 'headersize'), get(frf, 'recordsize'));

    %transpose arrays and construct names

    for f=1:numel(field_id)
        data{f} = data{f}';
    end

    %create structure

    data = cell2struct(data, load_fields);
else %ascii
    
    if (max(diff(i)))>1
        error('Can only load contiguous blocks from Ascii file')
    elseif (any(fix(i)~=i) )
        error('Fractional indices not allowed')
    else
        
        fid = fopen( fullfile( get(frf, 'path'), get(frf, 'filename') ), 'r' );

        if fid == -1
            error('Cannot open file')
        end
        
        skip = ones(nfields,1);
        skip(field_id) = 0;
        
        fmt = formatstr(fields, skip);
               
        %fseek to header offset
        fseek(fid, get(frf, 'headersize'), -1);    
        if i==-1
            data = textscan(fid, fmt);
        else
            data = textscan(fid, fmt, length(i), 'headerLines', i(1));
        end
    
        outdata = struct();
        ofs = 0;
        for f=1:numel(field_id)
            if length(fields(f))>1 && strcmp(type(fields(f)), 'char')
                outdata.(load_fields{f}) = data{1 + ofs};
                ofs = ofs + 1;
            else
                outdata.(load_fields{f}) = cell2mat( data( [1:length(fields(f))] + ofs ) );
                ofs = ofs + length(fields(f));
            end
        end
            
        data = outdata;
        
        fclose(fid);
    end
    
end

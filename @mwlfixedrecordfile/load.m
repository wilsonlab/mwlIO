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
    load_fields = cellstr(name(fields));
end

field_names = cellstr(name(fields));
[dummy, field_id] = ismember( load_fields,field_names );

field_id = field_id( field_id~=0 );
load_fields = field_names( field_id );

if isempty(load_fields)
     data = []
     return
end
    
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
    
    if any( i>=nrecords | i<0)
        error('Invalid index array (out of bounds)')
    end
    
    if any( fix(i) ~= i )
        error('Fractional indices not allowed')
    end 
    
    data = mwlio( fullfile(get(frf,'path'), get(frf, 'filename')), i, field_def(field_id,:), get(frf, 'headersize'), get(frf, 'recordsize'));

    %transpose arrays and construct names

     for f=1:numel(field_id)
%         nd = ndims( data{f} );
%         %permute only if nrecords>1, i.e. when nd>numel(size( fields(field_id) ) )
%         if nd>numel( size( fields( field_id ) ) )
%             data{f} = permute(data{f}, [nd 1:(nd-1)]);
%         end
        %if size(data{f},1)==1
            %data{f} = shiftdim(data{f}, ndims(data{f})-1);
        %end
        %data{f} = squeeze( data{f} );
        if strcmp(type(fields(f)), 'char') && length(fields(f))>1
            data{f} = cellstr( char(data{f})' )';
        end
            
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
            data = textscan(fid, fmt, 'whitespace', '\t');
        else
            data = textscan(fid, fmt, length(i), 'headerLines', i(1), ...
                            'whitespace', '\t');
        end
    
        outdata = struct();
        ofs = 0;
        
        field_id = sort(field_id);
        
        nrows = numel( data{1} );
        
        for f=1:numel(field_id)
            if length(fields(field_id(f)))>1 && strcmp(type(fields(field_id(f))), 'char')
                outdata.(name(fields(field_id(f)))) = data{1 + ofs}';
                ofs = ofs + 1;
            else
                outdata.(name(fields(field_id(f)))) = shiftdim( reshape( cell2mat( data( [1:length(fields(field_id(f)))] + ofs ) ), [ nrows size(fields(field_id(f)))] ), 1) ;
                ofs = ofs + length(fields(field_id(f)));
            end
        end
            
        data = outdata;
        
        fclose(fid);
    end
    
end

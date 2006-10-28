function frf = appendData(frf, data)
%APPENDDATA append new data to existing fixed record file
%
%  Syntax
%
%      f = appendData( f, data )
%
%  Description
%
%    This method appends data to file f. The parameter data can be any of
%    the following: a matrix with as many columns as there are fields in the
%    file; a structure, whose fields corresponds to the fields in the file;
%    a cell array with as many cells as there are fields.
%

%  Copyright 2005-2006 Fabian Kloosterman

%can only append data in append mode

if ~strcmp( get(frf, 'mode'), 'append' )
    error('Cannot append data if not in append mode')
end

fields = get(frf, 'fields');
nfields = numel(fields);

names = name(fields);


if isstruct(data)
    fldnames=fieldnames(data);
    if ~all(ismember(names,fldnames))
        error 'Fields in data structure do not match fields in file'
    end
    
    % convert struct to cell
    data = struct2cell( data );

    %permute cells to the same order as record fields in file
    [dummy, i1] = sort( names );
    [dummy, i1] = sort( i1 );
    [dummy, i2] = sort( fldnames );
    
    data = data(i2(i1));
end

%at this point data should a cell array
if ~iscell(data)
    error('Invalid data')
end

%number of cells should be the same as the number of record fields in file
if numel(data)~=nfields
    error('Incorrect number of record fields in data')
end

%check all record fields
for f =1:nfields

    %check data type and convert
    if strcmp(type(fields(f)),'char') && length(fields(f))>1
        if ismember( get(frf,'format'), {'binary'}) %binary file        
            if ischar(data{f})
                data{f} = uint8(data{f});
                if size(data{f},2) < length(fields(f))
                    data{f}(:,(size(data{f},2)+1):length(fields(f))) = 0;
                elseif size(data{f},2) > length(fields(f))
                    data{f} = data{f}(:,1:length(fields(f)));
                end
            elseif iscellstr(data{f})
                maxlen = length(fields(f));
                tmp=zeros(numel(data{f}), maxlen, 'uint8');
                for r=1:numel(data{f})
                    tmp(r, 1:numel(data{f}{r})) = uint8(data{f}{r});
                end
                data{f}=tmp;
            else
                error(['Invalid data for field ' num2str(f)])
            end
            data{f} = data{f}';
            nrows_field = size(data{f}, 2);
        else %ascii
            if ischar(data{f})
                %convert to cellstr
                data{f} = cellstr(data{f})
            elseif iscellstr(data{f})
                %pass
            else
                error(['Invalid data for field ' num2str(f)])
            end
            nrows_field = numel( data{f} );
        end
    else
        datatype = matcode(fields(f));
        try
            eval( ['data{f}=' datatype '(data{f});']);
        catch
            error(['Unable to convert field ' num2str(f) ' to ' datatype])
        end
        nrows_field=-1;
    end
    
    
    %check number of records
    if nrows_field<0
        %number of records in input data;
        nrows_field = numel(data{f}) ./ length(fields(f)); 
        if rem(nrows_field,1)~=0
            error 'Incorrect number of elements'
        end    
    end
    
    if f==1
        nrows = nrows_field;
    elseif nrows~=nrows_field    
        error('Incorrect number of rows')
    end
    
end

%write data to file
if ismember( get(frf,'format'), {'binary'})  %binary file
    mwlwrite( fullfile(frf), data, nrows )
else %ascii file
       
    %convert to cell matrix
    fo = 0;
    tmp = {};
    for f = 1:nfields
        if strcmp(type(fields(f)),'char') && length(fields(f))>1
            tmp([1:1]+fo,1:nrows) = data{f}(:)';
            fo = fo + 1;
        else    
            tmp([1:length(fields(f))]+fo,1:nrows) = mat2cell( reshape( data{f}, length(fields(f)), nrows ), ones(1, length(fields(f))), ones(nrows,1));
            fo = fo + length(fields(f));
        end           
    end        
    
    %save
    fmt = [formatstr(fields, [], '\t', 1) '\n'];
   
    fid = fopen(fullfile(frf), 'a');

    for i=1:nrows
        fprintf(fid, fmt, tmp{:,i});
    end
    
    fclose(fid);
    
end


%reload file
frf = reopen(frf);


return



    


if iscell(data)
    if numel(data)~=nfields
        error 'Incorrect number of fields in data'
    end    
    
    for f=1:nfields
        if strcmp(type(fields(f)), 'char') && length(fields(f))>1 && ismember( get(frf, 'format'), {'binary'})
            %datatype = 'uint8';
            data{f} = uint8(char(data{f}));
            %eval( ['data{f}=' datatype '(data{f});']);
            %if string length doesn't match pad array with zeros
            if size(data{f},2) < length(fields(f))
                data{f}(:,(size(data{f},2)+1):length(fields(f))) = 0;
            elseif size(data{f},2) > length(fields(f))
                data{f} = data{f}(:,1:length(fields(f)));
            end
            data{f} = data{f}';
        elseif ~strcmp(type(fields(f)), 'char')
            datatype = matcode(fields(f));
            eval( ['data{f}=' datatype '(data{f});']);
        end
        
        sz = size( data{f} ); %size of input data
        ndim_field = numel(size(fields(f))); %number of expected dimensions
        nrows_field = numel(data{f}) ./ length(fields(f)); %number of records in input data;
        if rem(nrows_field,1)~=0
           error 'Incorrect number of elements'
        end
        if f==1
    	    nrows = nrows_field;
        elseif nrows~=nrows_field    
            error('Incorrect number of rows')
        end
        
    end
    
    
elseif isstruct(data)
    fldnames = fieldnames(data);
    if ~all(ismember(names, fldnames))
        error 'Fields in data structure do not match fields in file'
    end
    
    %check the structure and convert if necessary
    for f=1:nfields

        if strcmp(type(fields(f)), 'char') && length(fields(f))>1 && ismember( get(frf, 'format'), {'binary'})
            %datatype = 'uint8';
            %eval( ['data.(name(fields(f))) = ' datatype '(data.(name(fields(f))));']);
            data.(names{f}) = uint8(char(data.(names{f})));
            %if string length doesn't match pad array with zeros
            if size(data.(names{f}),2) < length(fields(f))
                data.(names{f})(:,(size(data.(names{f}),2)+1):length(fields(f))) = 0;
            elseif size(data.(names{f}),2) > length(fields(f))
                data.(names{f}) = data.(names{f})(:,1:length(fields(f)));
            end       
            data.(names{f}) = data.(names{f})';
        elseif ~strcmp(type(fields(f)), 'char')
            datatype = matcode(fields(f));
            eval( ['data.(name(fields(f))) = ' datatype '(data.(name(fields(f))));']);
        end        
        
        
        
        sz = size( data.(names{f}) );
        ndim_field = numel(size(fields(f)));
        nrows_field = numel(data.(names{f})) ./ length(fields(f));
        if rem(nrows_field,1)~=0
            error 'Incorrect number of elements'
        end
        if f==1
            nrows = nrows_field;
        elseif nrows~=nrows_field
            error('Incorrect number of rows')
        end
    end
    
% elseif isnumeric(data) % for matrices there is no support for multiple element fields
%     if ndims(data)>2 || size(data,2)~=nfields
%         error 'Incorrect number of fields in data'
%     end
%     %create a cell array
%     tmpdata = {};
%     nrows = size(data,1);
%     for f=1:nfields
%         if strcmp(type(fields(f)), 'char') && length(fields(f))>1
%             datatype = 'char';
%         else
%             datatype = matcode( fields(f) );
%         end          
%         eval(['tmpdata{f}=' datatype '(data(:,f));']);
%     end
%     data = tmpdata;
%     clear tmpdata;
end

if ismember( get(frf, 'format'), {'binary'})
    %write data to file
    mwlwrite(fullfile(frf), data, nrows);
else %ascii
    fid = fopen(fullfile(frf), 'a');
    
    fmt = [formatstr(fields, [], '\t', 1) '\n'];
    
    if isstruct(data)
        %convert to cell matrix
        fo = 0;
        tmp = {};
        for f = 1:nfields
            if strcmp(type(fields(f)),'char') && length(fields(f))>1
                tmp([1:1]+fo, 1:nrows) = strtrim( mat2cell( char(data.(name(fields(f)))'), ones(nrows,1), length(fields(f))) );
                fo = fo + 1;
            else    
                tmp([1:length(fields(f))]+fo,1:nrows) = mat2cell( reshape( data.(name(fields(f))), length(fields(f)), nrows ), ones(1, length(fields(f))), ones(nrows,1) );
                fo = fo + length(fields(f));
            end
        end
    else
        %convert to cell matrix
        fo = 0;
        tmp = {};
        for f = 1:nfields
            if strcmp(type(fields(f)),'char') && length(fields(f))>1
                tmp([1:1]+fo,1:nrows) = strtrim( mat2cell( char(data{f}'), ones(nrows,1), length(fields(f))) );
                fo = fo + 1;
            else    
                tmp([1:length(fields(f))]+fo,1:nrows) = mat2cell( reshape( data{f}, length(fields(f)), nrows ), ones(1, length(fields(f))), ones(nrows,1));
                fo = fo + length(fields(f));
            end           
        end        
    end
    
    
    
    %save
    for i=1:nrows
        fprintf(fid, fmt, tmp{:,i});
    end
    
    fclose(fid);
end


%reload file
frf = reopen(frf);


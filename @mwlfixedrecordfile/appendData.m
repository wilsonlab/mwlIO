function frf = appendData(frf, data)
%APPENDDATA

%data can be a matrix, a struct or a cell array

%we'll have to compare the data with the field descriptions
%and convert if necessary
%final data is a cell array or structure that can be used be mwlwrite.mexglx

fields = get(frf, 'fields');
nfields = size(fields, 1);

if iscell(data)
    if length(data)~=nfields
        error 'Incorrect number of fields in data'
    end    
    
    for f=1:nfields
        if size(data{f}, 2) ~= fields{f, 4}
            error 'Incorrect number of elements'
        end
        if f==1
            nrows = size(data{f},1);
        elseif nrows~=size(data{f},1)
            error('Incorrect number of rows')
        end
        
        if strcmp(fields{f,2}, 'char') && fields{f,4}>1
            datatype = 'char';
        else
            datatype = mwltypemapping(fields{f, 2}, 'str2mat');
        end
        eval( ['data{f}=' datatype '(data{f});']);
    end
    
    
elseif isstruct(data)
    fldnames = fieldnames(data);
    if ~all(ismember(fields(:,1), fldnames))
        error 'Fields in data structure do not match fields in file'
    end
    
    %check the structure and convert if necessary
    for f=1:nfields
        if size(data.(fields{f,1}), 2) ~= fields{f, 4}
            error 'Incorrect number of elements'
        end
        if f==1
            nrows = size(data.(fields{f,1}),1);
        elseif nrows~=size(data.(fields{f,1}),1)
            error('Incorrect number of rows')
        end
        if strcmp(fields{f,2}, 'char') && fields{f,4}>1
            datatype = 'char';
        else
            datatype = mwltypemapping(fields{f, 2}, 'str2mat');
        end        
        eval( ['data.(fields{f,1}) = ' datatype '(data.(fields{f,1}));']);
    end
    
elseif isnumeric(data) % for matrices there is no support for multiple element fields
    if size(data,2)~=nfields
        error 'Incorrect number of fields in data'
    end
    %create a cell array
    tmpdata = {};
    nrows = size(data,1);
    for f=1:nfields
        if strcmp(fields{f,2}, 'char') && fields{f,4}>1
            datatype = 'char';
        else
            datatype = mwltypemapping(fields{f, 2}, 'str2mat');
        end          
        eval(['tmpdata{f}=' datatype '(data(:,f));']);
    end
    data = tmpdata;
    clear tmpdata;
end

if isbinary(frf)
    %write data to file
    mwlwrite(fullfile(frf), data, nrows);
else %ascii
    fid = fopen(fullfile(frf), 'a');
    fmt = [fieldformatstr(fields, [], '\t', 1) '\n'];
    if isstruct(data)
        %convert to cell matrix
        fo = 0;
        tmp = {};
        for f = 1:nfields
            if strcmp(fields{f,2},'char') && fields{f,4}>1
                tmp(1:nrows, [1:1]+fo) = mat2cell( data.(fields{f,1}), ones(nrows,1), fields{f,4});
                fo = fo + 1;
            else    
                tmp(1:nrows, [1:fields{f,4}]+fo) = mat2cell( data.(fields{f,1}), ones(nrows,1), ones(1, fields{f,4}));
                fo = fo + fields{f,4};
            end
        end
    else
        %convert to cell matrix
        fo = 0;
        tmp = {};
        for f = 1:nfields
            if strcmp(fields{f,2},'char') && fields{f,4}>1
                tmp(1:nrows, [1:1]+fo) = mat2cell( data{f}, ones(nrows,1), fields{f,4});
                fo = fo + 1;
            else    
                tmp(1:nrows, [1:fields{f,4}]+fo) = mat2cell( data{f}, ones(nrows,1), ones(1, fields{f,4}));
                fo = fo + fields{f,4};
            end           
        end        
    end
    
    %save
    for i=1:nrows
        fprintf(fid, fmt, tmp{i,:});
    end
    
    fclose(fid);
end


%reload file
frf = reopen(frf);


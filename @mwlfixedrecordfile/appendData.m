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
            
        datatype = mwltypemapping(fields{f, 2}, 'str2mat');
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
        datatype = mwltypemapping(fields{f, 2}, 'str2mat');
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
        datatype = mwltypemapping(fields{f, 2}, 'str2mat');
        eval(['tmpdata{f}=' datatype '(data(:,f));']);
    end
    data = tmpdata;
    clear tmpdata;
end

%write data to file
mwlwrite(fullfile(frf), data, nrows);

%reload file
frf = reopen(frf);


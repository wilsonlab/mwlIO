function frf = appendData(frf, data)
%APPENDDATA append new data to existing fixed record file
%
%   Syntax
%   f = appendData( f, data )
%
%   This method appends data to file f. The parameter data can be any of
%   the following: a matrix with as many columns as there are fields in the
%   file; a structure, whose fields corresponds to the fields in the file;
%   a cell array with as many cells as there are fields.
%
%   Example
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

fields = get(frf, 'fields');
nfields = numel(fields);

names = name(fields);

if iscell(data)
    if length(data)~=nfields
        error 'Incorrect number of fields in data'
    end    
    
    for f=1:nfields
        if size(data{f}, 2) ~= length(fields(f))
            error 'Incorrect number of elements'
        end
        if f==1
            nrows = size(data{f},1);
        elseif nrows~=size(data{f},1)
            error('Incorrect number of rows')
        end
        
        if strcmp(type(fields(f)), 'char') && length(fields(f))>1
            datatype = 'char';
        else
            datatype = matcode(fields(f));
        end
        eval( ['data{f}=' datatype '(data{f});']);
    end
    
    
elseif isstruct(data)
    fldnames = fieldnames(data);
    if ~all(ismember(names, fldnames))
        error 'Fields in data structure do not match fields in file'
    end
    
    %check the structure and convert if necessary
    for f=1:nfields
        if size(data.(names{f}), 2) ~= length(fields(f))
            error 'Incorrect number of elements'
        end
        if f==1
            nrows = size(data.(names{f}),1);
        elseif nrows~=size(data.(names{f}),1)
            error('Incorrect number of rows')
        end
        if strcmp(type(fields(f), 'char') && length(fields(f))>1
            datatype = 'char';
        else
            datatype = matcode(fields(f));
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
        if strcmp(type(fields(f)), 'char') && length(fields(f))>1
            datatype = 'char';
        else
            datatype = matcode( fields(f) );
        end          
        eval(['tmpdata{f}=' datatype '(data(:,f));']);
    end
    data = tmpdata;
    clear tmpdata;
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
                tmp(1:nrows, [1:1]+fo) = mat2cell( data.(names(fields(f))), ones(nrows,1), length(fields(f)));
                fo = fo + 1;
            else    
                tmp(1:nrows, [1:length(fields(f))]+fo) = mat2cell( data.(names(fields(f))), ones(nrows,1), ones(1, length(fields(f))));
                fo = fo + length(fields(f));
            end
        end
    else
        %convert to cell matrix
        fo = 0;
        tmp = {};
        for f = 1:nfields
            if strcmp(type(fields(f)),'char') && length(fields(f))>1
                tmp(1:nrows, [1:1]+fo) = mat2cell( data{f}, ones(nrows,1), length(fields(f)));
                fo = fo + 1;
            else    
                tmp(1:nrows, [1:length(fields(f))]+fo) = mat2cell( data{f}, ones(nrows,1), ones(1, length(fields(f))));
                fo = fo + length(fields(f));
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


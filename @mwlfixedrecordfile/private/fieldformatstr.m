function fmtstr = fieldformatstr(fields, skip, delimiter, fmttype)
%FORMATSTR convert fields to format string for use with textscan and fprintf
%
%   Syntax
%   format_string = formatstr( field, skip, delimiter, type )
%
%   This method converts melfield objects to format strings that can be
%   used by textscan and fprintf. The parameter skip is an optional vector
%   indicating for each field whether is should be skipped (1) or not (0).
%   Delimiter is an optional string used as a delimiter between field
%   format strings. The parameter type is used to select the type of format
%   string (0 for textscan compatible, 1 for fprintf compatible)
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

nfields = numel(fields);

if nargin<2 || isempty(skip)
    skip = zeros(nfields,1);
elseif ~isnumeric(skip) || numel(skip) ~= nfields
    error('Invalid skip vector')
end

if nargin<3 || isempty(delimiter)
    delimiter = '';
end

if nargin<4 || isempty(fmttype) || fmttype==0
    mapping = {'d', 'd', 'd', 'f', 'f', 's', 's', 'd'};
else
    mapping = {'u8', 'd16', 'd32', 'f', 'f', 's', 's', 'd32'};
end

fmtstr = '';

field_type = type( fields );

for f=1:nfields
    
    if skip(f)
        fmt =  '%*';
    else
        fmt = '%';
    end
    
    if field_type(f)==1 %char
        if size(fields(f))>1 %treat as string
            fmt = [fmt 's'];
        else
            fmt = [fmt field_type{f}];
        end
    elseif field_type(f)>=2 && field_type(f)<=8
        fmt = [fmt mapping{field_type(f)}];
    else
        error('Incorrect field type')
    end

    if ~field_type(f)==1 %char
        fmt2='';
    
        for i = 1:size(fields(f))
            fmt2 = [fmt2 fmt delimiter];
        end
    
        fmtstr = [fmtstr fmt2];
    else
        fmtstr = [fmtstr fmt delimiter];
    end
    
end

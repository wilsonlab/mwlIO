function fmtstr = fieldformatstr(fields, skip, delimiter, fmttype)
%FIELDFORMATSTR
% creates format string from field descriptions
% skip is an array that specifies whether field should be skipped or not

% $Id: fieldformatstr.m,v 1.1 2005/10/09 20:44:25 fabian Exp $

if nargin<4 || isempty(fmttype)
    fmttype = 0; % for textscan, 1 is for fprintf
end

if nargin<3 || isempty(delimiter)
    delimiter = '';
end

fmtstr = '';

nfields = size(fields, 1);

if nargin<2 || isempty(skip)
    skip = zeros(nfields,1);
end

for f=1:nfields
    if skip(f)
        fmt =  '%*';
    else
        fmt = '%';
    end
    
    typestr = fields{f,2};
    
    switch typestr
        case 'char'
            if fields{f,4}>1 %treat as string
                fmt = [fmt 's'];
            else
                if fmttype
                    fmt = [fmt 'd'];
                else
                    fmt = [fmt 'u8'];
                end
            end
        case 'short'
            if fmttype
                fmt = [fmt 'd'];
            else
                fmt = [fmt 'd16'];
            end
        case 'int'
            if fmttype
                fmt = [fmt 'd'];
            else
                fmt = [fmt 'd32'];
            end
        case 'float'
            fmt = [fmt 'f'];
        case 'double'
            fmt = [fmt 'f'];
        case 'ulong'
            if fmttype
                fmt = [fmt 'd'];
            else            
                fmt = [fmt 'd32'];
            end
        otherwise
            error('Incorrect field type')
    end
    
    if ~strcmp(typestr, 'char')
        fmt2='';
    
        for i = 1:(fields{f,4})
            fmt2 = [fmt2 fmt delimiter];
        end
    
        fmtstr = [fmtstr fmt2];
    else
        fmtstr = [fmtstr fmt delimiter];
    end
    
end


% $Log: fieldformatstr.m,v $
% Revision 1.1  2005/10/09 20:44:25  fabian
% *** empty log message ***
%

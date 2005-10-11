function fmtstr = fieldformatstr(fields, skip)
%FIELDFORMATSTR
% creates format string from field descriptions
% skip is an array that specifies whether field should be skipped or not

% $Id: fieldformatstr.m,v 1.1 2005/10/09 20:44:25 fabian Exp $

fmtstr = '';

nfields = size(fields, 1);

for f=1:nfields
    if skip(f)
        fmt =  '%*';
    else
        fmt = '%';
    end
    
    typestr = fields{f,2};
    
    switch typestr
        case 'char'
            if fields(4)>1 %treat as string
                fmt = [fmt 's'];
            else
                fmt = [fmt 'u8'];
            end
        case 'short'
            fmt = [fmt 'd16'];
        case 'int'
            fmt = [fmt 'd32'];
        case 'float'
            fmt = [fmt 'f'];
        case 'double'
            fmt = [fmt 'f'];
        case 'ulong'
            fmt = [fmt 'd32'];
        otherwise
            error('Incorrect field type')
    end
    
    fmt2='';
    
    for i = 1:(fields{f,4})
        fmt2 = [fmt2 fmt];
    end
    
    fmtstr = [fmtstr fmt2];
    
end


% $Log: fieldformatstr.m,v $
% Revision 1.1  2005/10/09 20:44:25  fabian
% *** empty log message ***
%

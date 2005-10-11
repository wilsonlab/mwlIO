function rfb = setFields(rfb, fields)
%SETFIELDS

% $Id: setFields.m,v 1.2 2005/10/11 19:02:33 fabian Exp $

%if ~rfb.isopen
%    error('File is closed')
if strcmp(get(rfb, 'mode'), 'r')
    error('File is not in write mode')
elseif ~get(rfb, 'headeropen')
    error('Header is already closed')
end

if ~iscell(fields)
    error('Expecting cell matrix of field descriptions')
end

nfields = size(fields, 1);

if nfields==0 | size(fields,2)~=4
    error('Incorrect size of cell matrix')
end

for f = 1:nfields
    
    if ~ischar(fields{f,1}) | ~ischar(fields{f,2}) | ~isscalar(fields{f,3}) | ~isscalar(fields{f,4})
        error('Invalid field')
    end
    
    if fields{f, 3} ~= mwltypemapping(fields{f, 2}, 'str2size')
        error('Incompatible size and type if field')
    end
    
    if fields{f,4} < 1
        error('Invalid number of elements')
    end
    
end

rfb.fields = fields;


% $Log: setFields.m,v $
% Revision 1.2  2005/10/11 19:02:33  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:49:17  fabian
% *** empty log message ***
%

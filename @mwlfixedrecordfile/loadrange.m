function data = loadrange(frf, fields, range, rangefield)
%LOADRANGE

% $Id: loadrange.m,v 1.1 2005/10/09 20:42:10 fabian Exp $

if nargin<3
    help(mfilename)
    return
end

if ~isbinary(frf)
    error('This function not implemented for ascii files');
end

try
    range = double(range);
catch
    error('Invalid range argument')
end

if (length(range)~=2)
    error('Range should be two element vector')
end

if nargin<4 | isempty(rangefield)
    %range = record indices
    data = load(frf, fields, range(1):range(2));
else
    %range = in field units
    flds = get(frf, 'fields');
    fieldid = find(strcmp(flds(:,1), rangefield));
    if isempty(fieldid)
        error('Invalid range field')
    end
    
    fielddef = [ sum( [ 0 flds{1:fieldid-1,3} ] ) mwltypemapping(flds{fieldid, 2}, 'str2mex') flds{fieldid,4} ];
    idrange = findrecord( fullfile( get(frf, 'path'), get(frf, 'filename') ), range, fielddef, get(frf, 'headersize'), get(frf, 'recordsize') );
    data = load(frf, fields, idrange(1):idrange(2));
end


% $Log: loadrange.m,v $
% Revision 1.1  2005/10/09 20:42:10  fabian
% *** empty log message ***
%

function i = findRecords(f, field, bounds)
%FINDRECORDS

% $Id: findRecords.m,v 1.1 2005/10/09 20:40:48 fabian Exp $

if nargin<3
    help(mfilename)
end

%fields = get(f, 'fields');
%nfields = size(fields, 1);

if ~isnumeric(bounds) & length(bounds)~=2
    error('Invalid bounds')
end

data = loadField(f, field);

i = find( data>=bounds(1) & data<=bounds(2) );


% $Log: findRecords.m,v $
% Revision 1.1  2005/10/09 20:40:48  fabian
% *** empty log message ***
%

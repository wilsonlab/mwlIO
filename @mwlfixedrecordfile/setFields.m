function frf = setFields(frf, fields)
%SETFIELDS

% $Id: setFields.m,v 1.1 2005/10/09 20:42:51 fabian Exp $

frf.mwlrecordfilebase = setFields(frf.mwlrecordfilebase, fields);

frf.recordsize = 0;

fields = get(frf, 'fields');
nfields = size(fields, 1);

for f=1:nfields
    frf.recordsize = frf.recordsize + fields{f,3}*fields{f,4};
end


% $Log: setFields.m,v $
% Revision 1.1  2005/10/09 20:42:51  fabian
% *** empty log message ***
%

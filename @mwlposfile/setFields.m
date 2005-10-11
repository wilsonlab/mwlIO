function pf = setFields(pf)
%SETFIELDS

% $Id: setFields.m,v 1.1 2005/10/09 20:47:34 fabian Exp $

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = {};
fields(1,1:4) = {'nitems' 'char' 1 1};
fields(2,1:4) = {'frame' 'char' 1 1};
fields(2,1:4) = {'timestamp' 'long' 4 1};
fields(2,1:4) = {'target x' 'short' 2 1};
fields(2,1:4) = {'target y' 'char' 1 1};

pf.mwlrecordfilebase = setFields(pf.mwlrecordfilebase, fields);


% $Log: setFields.m,v $
% Revision 1.1  2005/10/09 20:47:34  fabian
% *** empty log message ***
%

function ef = setFields(ef)
%SETFIELDS

% $Id: setFields.m,v 1.1 2005/10/09 20:32:58 fabian Exp $

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = {};
fields(1,1:4) = {'timestamp' 'long' 4 1};
fields(2,1:4) = {'string' 'char' 1 ef.string_size};

ef.mwlfixedrecordfile = setFields(ef.mwlfixedrecordfile, fields);


% $Log: setFields.m,v $
% Revision 1.1  2005/10/09 20:32:58  fabian
% *** empty log message ***
%

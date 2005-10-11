function pf = setFields(pf)
%SETFIELDS

% $Id: setFields.m,v 1.2 2005/10/11 19:02:11 fabian Exp $

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = {};
fields(1,1:4) = {'timestamp' 'long' 4 1};
fields(2,1:4) = {'xfront' 'short' 2 1};
fields(3,1:4) = {'xback' 'short' 2 1};
fields(4,1:4) = {'yfront' 'short' 2 1};
fields(5,1:4) = {'yback' 'short' 2 1};

pf.mwlfixedrecordfile = setFields(pf.mwlfixedrecordfile, fields);


% $Log: setFields.m,v $
% Revision 1.2  2005/10/11 19:02:11  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 19:54:24  fabian
% *** empty log message ***
%

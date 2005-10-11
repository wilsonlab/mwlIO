function data = load(ef, flds, i)
%LOAD

% $Id: load.m,v 1.1 2005/10/09 20:32:15 fabian Exp $

data = load(ef.mwlfixedrecordfile, flds, i);

if isfield(data, 'string')
    data.string = cellstr(char(data.string));
end


% $Log: load.m,v $
% Revision 1.1  2005/10/09 20:32:15  fabian
% *** empty log message ***
%

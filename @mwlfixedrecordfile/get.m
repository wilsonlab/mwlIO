function val = get(frf, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:41:04 fabian Exp $

try
    val = frf.(propName);
catch
    val = get(frf.mwlrecordfilebase, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:41:04  fabian
% *** empty log message ***
%

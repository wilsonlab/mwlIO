function val = get(pf, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:45:31 fabian Exp $

try
    val = pf.(propName);
catch
    val = get(pf.mwlrecordfilebase, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:45:31  fabian
% *** empty log message ***
%

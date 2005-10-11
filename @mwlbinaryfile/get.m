function val = get(bf, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 19:50:44 fabian Exp $

try
    val = bf.(propName);
catch
    val = get(bf.mwlfilebase, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 19:50:44  fabian
% *** empty log message ***
%

function val = get(ef, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:26:30 fabian Exp $

try
    val = ef.(propName);
catch
    val = get(ef.mwlfixedrecordfile, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:26:30  fabian
% *** empty log message ***
%

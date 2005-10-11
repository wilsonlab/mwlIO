function val = get(rfb, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:48:37 fabian Exp $

try
    val = rfb.(propName);
catch
    val = get(rfb.mwlfilebase, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:48:37  fabian
% *** empty log message ***
%

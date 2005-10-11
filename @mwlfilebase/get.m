function val = get(fb, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:36:58 fabian Exp $

try
    val = fb.(propName);
catch
    error('No such property.')
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:36:58  fabian
% *** empty log message ***
%

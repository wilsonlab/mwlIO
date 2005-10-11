function val = get(wf, propName)
%GET

% $Id: get.m,v 1.1 2005/10/09 20:51:46 fabian Exp $

try
    val = wf.(propName);
catch
    val = get(wf.mwlfixedrecordfile, propName);
end


% $Log: get.m,v $
% Revision 1.1  2005/10/09 20:51:46  fabian
% *** empty log message ***
%

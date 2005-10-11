function val = getParam(sh, parm)
%GETPARAM

% $Id: getParam.m,v 1.1 2005/10/09 20:54:54 fabian Exp $

if ~ischar(parm) | strcmp(parm, '')
    error('Parameter name should be non-empty string')
end

id = find( strcmp(sh.parms(:,1), parm) );

if (length(id)>1)
    error('Internal error: same parameter present multiple times')
end

if length(id) == 0
    val = [];
else
    val = sh.parms{id,2};
end


% $Log: getParam.m,v $
% Revision 1.1  2005/10/09 20:54:54  fabian
% *** empty log message ***
%

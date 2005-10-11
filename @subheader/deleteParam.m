function sh = deleteParam(sh, parm)
%DELETEPARAM

% $Id: deleteParam.m,v 1.1 2005/10/09 20:53:46 fabian Exp $

if ~ischar(parm) | strcmp(parm, '')
    error('Parameter name should be non-empty string')
end

id = find( strcmp(sh.parms(:,1), parm) );

if (length(id)>1)
    error('Internal error: same parameter present multiple times')
end

if length(id)==1
    sh.parms(id,:) = [];
end


% $Log: deleteParam.m,v $
% Revision 1.1  2005/10/09 20:53:46  fabian
% *** empty log message ***
%

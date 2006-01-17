function sh = deleteParam(sh, parm)
%DELETEPARAM remove parameter from subheader
%
%   Syntax
%   h = deleteParam( h, param )
%
%   This method will remove the parameter param from the subheader h.
%
%   Example
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

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


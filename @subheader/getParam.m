function val = getParam(sh, parm)
%GETPARAM get value of subheader parameter
%
%   Syntax
%   val = getParam( h, param )
%
%   Examples
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

if length(id) == 0
    val = [];
else
    val = sh.parms{id,2};
end


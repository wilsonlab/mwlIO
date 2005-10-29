function val = getParam(sh, parm)
%GETPARAM

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

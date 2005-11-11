function sh = setParam(sh, parm, val)
%SETPARAM

% $Id: setParam.m,v 1.1 2005/10/09 20:55:47 fabian Exp $

if ~ischar(parm) | strcmp(parm, '')
    error('Parameter name should be non-empty string')
end

if isempty(val)
    error('Value cannot be empty')
end

id = find( strcmp(sh.parms(:,1), parm) );

if (length(id)>1)
    error('Internal error: same parameter present multiple times')
end

%convert parameter
if ischar(val)
    %fine
elseif isnumeric(val)
    val = num2str(val, 8);
elseif iscell(val)
    val = char(val);
else
    error('Conversion of value to string is not possible')
end
  
if length(id)==0
    %no such parameter yet, append
    sh.parms(end+1,1:2) = {parm val};
else
    sh.parms(id,1:2) = {parm val};
end


% $Log: setParam.m,v $
% Revision 1.1  2005/10/09 20:55:47  fabian
% *** empty log message ***
%

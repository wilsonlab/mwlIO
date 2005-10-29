function [val, subh] = getParam(h, parm)
%GETPARAM

if ~ischar(parm) | strcmp(parm, '')
    error('Parameter name should be non-empty string')
end

val={};
subh=[];

for i = 1:len(h)
    ft = getParam(h.subheaders(i), parm);
    if ~isempty(ft)
        val{end+1} = ft;
        subh(end+1) = i;
    end
end


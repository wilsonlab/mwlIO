function [val, subh] = getParam(h, parm)
%GETPARAM get value of header parameter
%
%   Syntax
%   [val, sh] = getParam( h, param )
%
%   This method will return the value of parameter param in the subheaders
%   of h. The subheader indices will be returned in sh.
%
%   Examples
%
%   See also 
%
%  Copyright 2005-2006 Fabian Kloosterman

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


function [val, subh] = getParam(h, parm)
%GETPARAM get value of header parameter
%
%  val=GETPARAM(h, param) returns value of a header parameter. All 
%  subheaders will be searched and all occurences of the parameter will
%  be returned.
%
%  [val, subhdr]=GETPARAM(h, param) returns a list indices of subheaders
%  in which the parameter was found.
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
  help(mfilename)
  return
end

if ~ischar(parm) || strcmp(parm, '')
    error('header:getParam:invalidParameter', ...
          'Parameter name should be non-empty string')
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


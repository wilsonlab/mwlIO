function b = hasParam(sh,param)
%HASPARAM test for presence of parameter in subheader
%
%  b=HASPARAM(sh,param) return 1 if subheader defines parameter
%  param and 0 otherwise.
%

%  Copyright 2008-2008 Fabian Kloosterman

if nargin<2
    help(mfilename)
    return
end

if ~ischar(param) || strcmp(param, '')
  error('subheader:hasParam:invalidParameter', ...
        'Parameter name should be non-empty string')
end

b = any( strcmp(sh.parms(:,1), param) );
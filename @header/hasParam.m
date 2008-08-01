function b = hasParam(h,param)
%HASPARAM test for presence of parameter in header
%
%  b=HASPARAM(h,param) return 1 for each subheader in header h that
%  define parameter param and 0 otherwise.
%

%  Copyright 2008-2008 Fabian Kloosterman

if nargin<2
    help(mfilename)
    return
end

if ~ischar(param) || strcmp(param, '')
  error('header:hasParam:invalidParameter', ...
        'Parameter name should be non-empty string')
end

nh = length(h.subheaders);

b = false(nh,1);

for k=1:nh
    
    b(k) = hasParam( h.subheaders(k), param );
    
end

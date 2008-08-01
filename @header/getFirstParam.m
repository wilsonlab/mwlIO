function val=getFirstParam(h,param)
%GETFIRSTPARAM get first available value of parameter
%
%  val=GETFIRSTPARAM(h,param) returns the value of the parameter
%  param from the first subheader in the header h that defines that
%  parameter.

%  Copyright 2008-2008 Fabian Kloosterman

if nargin<2
    help(mfilename)
    return
end

if ~ischar(param) || strcmp(param, '')
  error('header:getFirstParam:invalidParameter', ...
        'Parameter name should be non-empty string')
end

nh = length(h.subheaders);

val = NaN;

for k=1:nh
    if hasParam( h.subheaders(k), param )
        val = getParam( h.subheaders(k), param );
        break
    end
end

if isnan(val)
      error('header:getFirstParam', ['Parameter is not defined in any ' ...
                          'subheader'])
end
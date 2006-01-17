function bf = set(bf,varargin)
%SET set object properties and return the updated object
%
%   Syntax
%   f = set( f, property1, value1, property2, value2, ...)
%
%   Valid properties that can be set for mwlboundfile objects (in addition
%   to those inherited from mwlfilebase): none
%
%   Examples
%
%   See also 

%  Copyright 2005-2006 Fabian Kloosterman

propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    bf.mwlfilebase = set(bf.mwlfilebase, prop, val);
end
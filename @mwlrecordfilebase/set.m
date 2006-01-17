function rfb = set(rfb,varargin)
%SET set object properties and return the updated object
%
%   Syntax
%   f = set( f, property1, value1, property2, value2, ...)
%
%   Valid properties that can be set for mwlrecordfilebase objects which
%   are in 'write' or 'overwrite' mode (in addition to those inherited from
%   mwlfilebase): 'fields'
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
    switch prop
        case 'fields'
            rfb = setFields(rfb, val);
        otherwise
            rfb.mwlfilebase = set(rfb.mwlfilebase, prop, val);
    end
end

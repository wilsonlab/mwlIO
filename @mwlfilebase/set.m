function fb = set(fb,varargin)
%SET set object properties and return the updated object
%
%  Syntax
%
%      f = set( f, property1, value1, property2, value2, ...)
%
%  Description
%
%    Valid properties that can be set for mwlfilebase objects which are in
%    'write' or 'overwrite' mode: 'header', 'format'
%

%  Copyright 2005-2006 Fabian Kloosterman

if ismember( fb.mode, {'read', 'append'} )
    error(['File is in ' fb.mode ' mode')
end
    

propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    switch prop
    case 'header'
        if ~isa(val, 'header')
            error('Invalid header')
        else
            fb.header = val;
        end
    case 'binary'
        if ~ismember(val, {'binary', 'ascii'})
            error('Invalid format')
        else
            fb.format = val;
        end            
    otherwise
        error('Cannot set this property')
    end
end

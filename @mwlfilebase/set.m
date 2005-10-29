function fb = set(fb,varargin)
% SET Set properties and return the updated object

propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    switch prop
    case 'header'
        if ~fb.headeropen
            error('Header is already closed.')
        elseif ~isa(val, 'header')
            error('Not a header.')
        else
            fb.header = val;
        end
    case 'binary'
        if ~fb.headeropen
            error('Header is already closed.')
        elseif (val~=0 & val~=1)
            error('Invalid value for binary parameter')
        else
            fb.binary = val;
        end            
    otherwise
        error('Cannot set this property')
    end
end

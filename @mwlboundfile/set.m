function bf = set(bf,varargin)
% SET


propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    bf.mwlfilebase = set(bf.mwlfilebase, prop, val);
end
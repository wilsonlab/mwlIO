function bf = set(bf,varargin)
% SET

% $Id: set.m,v 1.1 2005/10/09 20:58:08 fabian Exp $

propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    switch prop
    otherwise
        bf.mwlfilebase = set(bf.mwlfilebase, prop, val);
    end
end


% $Log: set.m,v $
% Revision 1.1  2005/10/09 20:58:08  fabian
% *** empty log message ***
%

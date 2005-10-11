function frf = set(frf,varargin)
% SET

% $Id: set.m,v 1.1 2005/10/09 20:43:25 fabian Exp $

propertyArgIn = varargin;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    switch prop
        otherwise
            frf.mwlrecordfilebase = set(frf.mwlrecordfilebase, prop, val);
    end
end


% $Log: set.m,v $
% Revision 1.1  2005/10/09 20:43:25  fabian
% *** empty log message ***
%

function pf = setFields(pf)
%SETFIELDS create fields for new record file
%
%   Syntax
%   f = setFields( f, fields )
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = mwlField( {'timestamp', 'xfront', 'xback', 'yfront', 'yback'}, {'long', 'short', 'short', 'short', 'short'}, 1);

pf.mwlfixedrecordfile = setFields(pf.mwlfixedrecordfile, fields);

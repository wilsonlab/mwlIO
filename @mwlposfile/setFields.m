function pf = setFields(pf)
%SETFIELDS create fields for new pos file
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

fields = mwlField( {'nitems', 'frame', 'timestamp', 'target x', 'target y'}, {'char', 'char', 'long', 'short', 'char'}, 1);

pf.mwlrecordfilebase = setFields(pf.mwlrecordfilebase, fields);


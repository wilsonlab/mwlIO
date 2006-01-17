function ef = setFields(ef)
%SETFIELDS create fields for new event file
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

fields = mwlField({'timestamp', 'string'}, {'ulong', 'char'}, [1 ef.string_size]);

ef.mwlfixedrecordfile = setFields(ef.mwlfixedrecordfile, fields);

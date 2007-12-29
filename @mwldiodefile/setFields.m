function pf = setFields(pf)
%SETFIELDS create fields for new record file
%
%  f=SETFIELDS(f) sets the fields for a mwl diode file. This function
%  does not take any other arguments than the file object, since the
%  fields are fixed. A diode file has the following fields:
%   | field name | field type | field size |
%   ----------------------------------------
%   | timestamp  | long       | 1          |
%   | xfront     | short      | 1          |
%   | xback      | short      | 1          |
%   | yfront     | short      | 1          |
%   | yback      | short      | 1          |
%

%  Copyright 2005-2008 Fabian Kloosterman

if nargin>1
    warning('mwldiodefile:setFields:invalidFields', ...
            'This file format has fixed fields. Arguments are ignored.')
end

fields = mwlfield( {'timestamp', 'xfront', 'xback', 'yfront', 'yback'}, {'long', 'short', 'short', 'short', 'short'}, 1);

pf.mwlfixedrecordfile = setFields(pf.mwlfixedrecordfile, fields);

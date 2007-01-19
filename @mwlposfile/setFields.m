function pf = setFields(pf)
%SETFIELDS create fields for new pos file
%
%  f=SETFIELDS(f) sets the fields for a mwl pos file. This function
%  does not take any other arguments than the file object, since the
%  fields are fixed. An pos file has the following fields (where 'target
%  x' and 'target_y' repeat 0-255 times):
%   | field name | field type | field size |
%   ----------------------------------------
%   | nitems     |  char      |  1         |
%   | frame      |  char      |  1         |
%   | timestamp  |  long      |  1         |
%   | target x   |  short     |  1         |
%   | target y   |  char      |  1         |
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin>1
    warning('mwlposfile:setFields:invalidFields', ...
            'This file format has fixed fields. Arguments are ignored.')
end

fields = mwlfield( {'nitems', 'frame', 'timestamp', 'target x', 'target y'}, {'char', 'char', 'long', 'short', 'char'}, 1);

pf.mwlrecordfilebase = setFields(pf.mwlrecordfilebase, fields);


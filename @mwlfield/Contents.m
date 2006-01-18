% @MWLFIELD
%
% Creation
%   mwlfield     - constructor
%
% Field information
%   byteoffset   - byte offsets for field
%   code         - return the field type code
%   elementsize  - return the field type size
%   length       - return the number of elements in a field
%   matcode      - return the field type converted to matlab type
%   mexcode      - return the field type converted to mex type
%   name         - return the field name
%   size         - return the total field size in bytes
%   type         - return the field type
%
% Conversions
%   formatstr    - convert fields to format string for use with textscan and fprintf
%   mex_fielddef - return a field definition cell array for use in mex files
%   print        - print mwlfield information in mwl header format
%
% Misc
%   display      - show field information
%   eq           - equality test for mwlfield objects
%   ismember     - TRUE if set member
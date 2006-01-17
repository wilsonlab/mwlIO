function val = get(rfb, propName)
%GET get oject properties
%
%   Syntax
%   value = get(f, property)
%
%   Valid properties for mwlrecordfilebase objects are (in addition to
%   those inherited from mwlfilebase): 'fields'
%
%   Examples
%
%   See also MWLFILEBASE

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = rfb.(propName);
catch
    val = get(rfb.mwlfilebase, propName);
end
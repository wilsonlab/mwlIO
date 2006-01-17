function val = get(bf, propName)
%GET get oject properties
%
%   Syntax
%   value = get(f, property)
%
%   Valid properties for mwlboundfile objects are (in addition to
%   those inherited from mwlfilebase): none
%
%   Examples
%
%   See also MWLFILEBASE

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = bf.(propName);
catch
    val = get(bf.mwlfilebase, propName);
end
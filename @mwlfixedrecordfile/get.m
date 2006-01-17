function val = get(frf, propName)
%GET get oject properties
%
%   Syntax
%   value = get(f, property)
%
%   Valid properties for mwlfixedrecordfile objects are (in addition to
%   those inherited from mwlrecordfilebase): 'recordsize', 'nrecords'
%
%   Examples
%
%   See also MWLFILEBASE

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = frf.(propName);
catch
    val = get(frf.mwlrecordfilebase, propName);
end


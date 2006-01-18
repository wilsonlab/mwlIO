function val = get(pf, propName)
%GET get oject properties
%
%  Syntax
%
%      value = get(f, property)
%
%  Description
%
%    Valid properties for mwlposfilebase objects are (in addition to
%    those inherited from mwlrecordfilebase): 'currentrecord',
%    'currentoffset', 'currenttimestamp', 'nrecords'
%
%  See also MWLRECORDFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = pf.(propName);
catch
    val = get(pf.mwlrecordfilebase, propName);
end


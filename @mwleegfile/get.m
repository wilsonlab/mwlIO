function val = get(ef, propName)
%GET get oject properties
%
%   Syntax
%   value = get(f, property)
%
%   Valid properties for mwleegfile objects are (in addition to
%   those inherited from mwlfixedrecordfile): 'nsamples', 'nchannels'
%
%   Examples
%
%   See also MWLFILEBASE

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = ef.(propName);
catch
    val = get(ef.mwlfixedrecordfile, propName);
end


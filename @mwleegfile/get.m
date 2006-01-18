function val = get(ef, propName)
%GET get oject properties
%
%  Syntax
%
%      value = get(f, property)
%
%  Description
%
%    Valid properties for mwleegfile objects are (in addition to
%    those inherited from mwlfixedrecordfile): 'nsamples', 'nchannels'
%
%  See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

try
    val = ef.(propName);
catch
    val = get(ef.mwlfixedrecordfile, propName);
end


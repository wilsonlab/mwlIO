function ef = setFields(ef)
%SETFIELDS create fields for new eeg file
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

fields = mwlField({'timestamp', 'data'}, {'long', 'short'}, [1 ef.nchannels*ef.nsamples]);

ef.mwlfixedrecordfile = setFields(ef.mwlfixedrecordfile, fields);

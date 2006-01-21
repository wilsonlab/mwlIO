function offsets = getRecordOffsets(pf, range)
%GETRECORDOFFSETS retrieve byte offsets for a range of position records
%
%  Syntax
%
%      offsets = getRecordOffsets( f [,range] )
%
%  Description
%
%    This method will return the byte offsets into the file of a range of
%    records. The range parameter is a two-element vector specifying the
%    record range (default is all records). After completion of this method,
%    the current record has been set to the first record in range.
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2 || isempty(range)
    range = [0 pf.nrecords-1];
end

try
    range = double(range);
catch
    error('Invalid range argument')
end

if (length(range)~=2)
    error('Range should be two element vector')
end

pf = setCurrentRecord(pf, range(1));

n = loadrange(pf,{'nitems'}, range);
offsets = cumsum([0 ; double(n.nitems(1:end-1)) *3 + 6]) +get(pf, 'headersize');

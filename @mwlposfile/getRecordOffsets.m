function offsets = getRecordOffsets(pf, range)
%GETRECORDOFFSETS

% $Id: getRecordOffsets.m,v 1.1 2005/10/09 20:45:52 fabian Exp $

if nargin<2 | isempty(range)
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


% $Log: getRecordOffsets.m,v $
% Revision 1.1  2005/10/09 20:45:52  fabian
% *** empty log message ***
%

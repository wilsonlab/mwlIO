function f = setCurrentRecord(f, recid)
%SETCURRENTRECORD move file pointer to record
%
%   Syntax
%   f = setCurrentRecord( f, record_id)
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if ismember(get(f, 'mode'), {'write', 'overwrite'})
    error('Cannot set current record in write mode')
end

if recid > get(f, 'nrecords') | recid<0
    error('Invalid record index')
end

if recid == f.currentrecord
    offset = f.currentoffset;
    index = 0;
    record = f.currentrecord;
elseif recid < f.currentrecord
    %search from start of file
    offset = get(f, 'headersize');
    index = recid;
    record = 0;
else
    %search from current record
    offset = f.currentoffset;
    index = recid - f.currentrecord;
    record = f.currentrecord;
end

[newrecid, newoffset, newtimestamp] = posfindrecord( fullfile(get(f, 'path'), get(f, 'filename')), get(f, 'headersize'), index );

f.currentrecord = record + newrecid;
f.currentoffset = newoffset;
f.currenttimestamp = newtimestamp;

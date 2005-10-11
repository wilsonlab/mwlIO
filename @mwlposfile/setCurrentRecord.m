function f = setCurrentRecord(f, recid)
%SETCURRENTRECORD

% $Id: setCurrentRecord.m,v 1.1 2005/10/09 20:47:02 fabian Exp $

if strcmp(get(f, 'mode'), 'w')
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


% $Log: setCurrentRecord.m,v $
% Revision 1.1  2005/10/09 20:47:02  fabian
% *** empty log message ***
%

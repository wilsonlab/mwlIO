function b = subsref(frf,s)
%SUBSREF subscripted indexing
%
%  Syntax
%
%      f.property
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    if strcmp(s.subs, 'nrecords')
        b = get(frf, 'nrecords');
    elseif strcmp(s.subs, 'recordsize')
        b = frf.recordsize;
    else
        b = subsref(frf.mwlrecordfilebase, s);
    end
end
function b = subsref(rfb,s)
%SUBSREF subscripted indexing
%
%  val=SUBSREF(f, subs) allows access to mwlrecordfilebase object
%  properties using the object.property syntax.
%


%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    flds = {'fields'};
    id = find( strcmp(flds, s.subs) );
    if ~isempty(id)
        b = rfb.(flds{id});
    else
        b = subsref(rfb.mwlfilebase, s);
    end
end

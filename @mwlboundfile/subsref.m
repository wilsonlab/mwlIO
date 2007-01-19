function b = subsref(bf,s)
%SUBSREF subscripted indexing for mwlboundfile objects
%
%  val=SUBSREF(f, subs) allows acces to mwlboundfile object properties
%  using the object.property syntax.
%
%  Example
%    f = mwlboundfile( 'test.dat' );
%    filesize = f.filesize;
%
%  See also: MWLBOUNDFILE/GET

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    b = subsref(bf.mwlfilebase, s);
end
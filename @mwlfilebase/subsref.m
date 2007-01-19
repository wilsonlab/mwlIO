function b = subsref(fb,s)
%SUBSREF subscripted indexing for mwlfilebase objects
%
%  val=SUBSREF(f, subs) allows access to mwlfilebase object properties
%  using the object.property syntax.
%
%  Example
%    f = mwlfilebase( 'test.dat' );
%    filesize = f.filesize;
%
%  See also MWLFILEBASE/GET
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    b = get(fb, s.subs);
end


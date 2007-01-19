function retval = type( field )
%TYPE field type
%
%  t=TYPE(f) returns the data types of all fields in the mwlfield object.
%
%  Example
%    field = mwlfield( 'test', 8, 1 );
%    type( field )  % will return: 'ulong'
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2str');
function retval = type( field )
%TYPE return the field type as a string
%
%   Syntax
%   t = type( field )
%
%   Examples
%   field = mwlfield( 8, 1 );
%   type( field )  % will return: 'ulong'
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2str' );
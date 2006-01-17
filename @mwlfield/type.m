function retval = type( field )
%TYPE return the field type
%
%   Syntax
%   n = type( field )
%
%   Examples
%   field = mwlfield( 'test', 8, 1 );
%   type( field )  % will return: 'ulong'
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2str');
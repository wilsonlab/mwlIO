function retval = elementsize( field )
%ELEMENTSIZE return the field type size
%
%   Syntax
%   sz = elementsize( field )
%
%   Examples
%   field = mwlfield( 'char', 1 );
%   elementsize( field )  % will return: 1
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2size');
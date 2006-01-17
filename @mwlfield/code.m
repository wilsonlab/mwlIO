function retval = code( field )
%CODE return the field type code
%
%   Syntax
%   c = code( field )
%
%   Examples
%   field = mwlfield( 'char', 1 );
%   code( field )  % will return: 1
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = [field.type];
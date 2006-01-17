function retval = size( field )
%SIZE return the total field size in bytes
%
%   Syntax
%   sz = size( field )
%
%   Examples
%   field = mwlfield( 'short', 2 );
%   size( field )  % will return: 6
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2size');
retval = retval.*[field.n];
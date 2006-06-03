function retval = bytesize( field )
%BYTESIZE return the total field size in bytes
%
%  Syntax
%
%      sz = bytesize( field )
%
%  Examples
%
%      field = mwlfield( 'test', 'short', 2 );
%      bytesize( field )  % will return: 4
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = mwltypemapping( [field.type], 'code2size');
retval = retval .* length( field );

function retval = byteoffset( field )
%BYTEOFFSET byte offsets for field
%
%  Syntax
%
%      b = byteoffset( field )
%
%  Examples
%
%      field = mwlfield( {'test', 'dummy'} );
%      b = byteoffset( field );  %will return:  
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = bytesize( field );
retval = cumsum( [0 retval(1:end-1)] );

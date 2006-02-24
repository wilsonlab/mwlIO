function retval = size( field )
%SIZE return the total field size in bytes
%
%  Syntax
%
%      sz = size( field )
%
%  Examples
%
%      field = mwlfield( 'test', 'short', 2 );
%      size( field )  % will return: 2
%

%  Copyright 2006-2006 Fabian Kloosterman

if numel(field)==1
    retval = field.n;
else
    retval = { field.n };
end
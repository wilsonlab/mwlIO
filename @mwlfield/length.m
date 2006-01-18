function retval = length( field )
%LENGTH return the number of elements in a field
%
%  Syntax
%
%      sz = length( field )
%
%  Examples
%
%      field = mwlfield( 'test', 'short', 2 );
%      length( field )  % will return: 2
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = [field.n];
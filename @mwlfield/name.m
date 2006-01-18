function retval = name( field )
%NAME return the field name
%
%  Syntax
%
%      n = name( field )
%
%  Examples
%
%      field = mwlfield( 'test', 8, 1 );
%      name( field )  % will return: 'test'
%

%  Copyright 2006-2006 Fabian Kloosterman

retval = {field.name};
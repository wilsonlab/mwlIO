function retval = matcode( field )
%MATCODE return the field type converted to matlab type
%
%  Syntax
%
%      m = matcode( field )
%
%  Examples
%
%      field = mwlfield( 'test', 'char', 1 );
%      matcode( field )  % will return: 'uint8'
%

%  Copyright 2006-2006 Fabian Kloosterman

typestr = mwltypemapping( [field.type], 'code2str');
retval = mwltypemapping( typestr, 'str2mat');
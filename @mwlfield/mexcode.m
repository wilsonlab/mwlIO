function retval = mexcode( field )
%MEXCODE return the field type converted to mex type
%
%  Syntax
%
%      m = mexcode( field )
%
%  Examples
%
%      field = mwlfield( 'test', 'char', 1 );
%      mexcode( field )  % will return: 9
%

%  Copyright 2006-2006 Fabian Kloosterman

typestr = mwltypemapping( [field.type], 'code2str');
retval = mwltypemapping( typestr, 'str2mex');
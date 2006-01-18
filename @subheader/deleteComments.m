function sh = deleteComments(sh)
%DELETECOMMENTS remove all comments from subheader
%
%  Syntax
%
%      h = deleteCOmments( h )
%

%  Copyright 2005-2006 Fabian Kloosterman

i = find( strcmp(sh.parms(:,1), '') );

sh.parms(i,:) = [];


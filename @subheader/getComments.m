function [result, i] = getComments(sh)
%GETCOMMENTS return all comments in subheader
%
%  Syntax
%
%      [c, i] = getComments( h )
%
%  Description
%
%    This method will return all comments c in subheader h. the indices at
%    which those comments were found in the subheader are returned in i.
%

%  Copyright 2005-2006 Fabian Kloosterman

i = find( strcmp(sh.parms(:,1), '') );

result = sh.parms(i,2);


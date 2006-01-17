function sh = addComment(sh, comment)
%ADDCOMMENT add comment to subheader
%
%   Syntax
%   h = addComment( h, comment )
%
%   This method adds the comment string to a subheader.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if ~ischar(comment)
    error('Expecting comment string')
end

sh.parms(end+1,1:2) = {'' comment};


function sh = addComment(sh, comment)
%ADDCOMMENT

% $Id: addComment.m,v 1.1 2005/10/09 20:53:18 fabian Exp $

if ~ischar(comment)
    error('Expecting comment string')
end

sh.parms(end+1,1:2) = {'' comment};


% $Log: addComment.m,v $
% Revision 1.1  2005/10/09 20:53:18  fabian
% *** empty log message ***
%

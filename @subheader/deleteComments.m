function sh = deleteComments(sh)
%DELETECOMMENTS

% $Id: deleteComments.m,v 1.1 2005/10/09 20:53:31 fabian Exp $

i = find( strcmp(sh.parms(:,1), '') );

sh.parms(i,:) = [];


% $Log: deleteComments.m,v $
% Revision 1.1  2005/10/09 20:53:31  fabian
% *** empty log message ***
%

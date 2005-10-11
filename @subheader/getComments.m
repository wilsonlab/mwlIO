function [result, i] = getComments(sh)
%GETCOMMENTS

% $Id: getComments.m,v 1.1 2005/10/09 20:54:34 fabian Exp $

i = find( strcmp(sh.parms(:,1), '') );

result = sh.parms(i,2);


% $Log: getComments.m,v $
% Revision 1.1  2005/10/09 20:54:34  fabian
% *** empty log message ***
%

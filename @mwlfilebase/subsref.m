function b = subsref(fb,s)
% SUBSREF

% $Id: subsref.m,v 1.2 2005/10/11 19:02:19 fabian Exp $

switch s.type
case '.'
    flds = {'mode', 'filename', 'path', 'headeropen', 'header', 'headersize', 'filesize'};
    id = find( strcmp(flds, s.subs) );
    if ~isempty(id)
        b = fb.(flds{id});
    else
        error('No such property.')
    end
end


% $Log: subsref.m,v $
% Revision 1.2  2005/10/11 19:02:19  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:39:09  fabian
% *** empty log message ***
%

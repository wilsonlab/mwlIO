function b = subsref(bf,s)
% SUBSREF 

% $Id: subsref.m,v 1.1 2005/10/09 19:52:18 fabian Exp $

switch s.type
case '.'
    flds = {};
    id = find( strcmp(flds, s.subs) );
    if ~isempty(id)
        b = bf.(flds{id});
    else
        b = subsref(bf.mwlfilebase, s);
    end
end


% $Log: subsref.m,v $
% Revision 1.1  2005/10/09 19:52:18  fabian
% *** empty log message ***
%

function b = subsref(rfb,s)
% SUBSREF 

% $Id: subsref.m,v 1.1 2005/10/09 20:49:57 fabian Exp $

switch s.type
case '.'
    flds = {'fields', 'currentrecord', 'nrecords'};
    id = find( strcmp(flds, s.subs) );
    if ~isempty(id)
        b = rfb.(flds{id});
    else
        b = subsref(rfb.mwlfilebase, s);
    end
end


% $Log: subsref.m,v $
% Revision 1.1  2005/10/09 20:49:57  fabian
% *** empty log message ***
%

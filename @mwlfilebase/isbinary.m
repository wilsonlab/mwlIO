function result = isbinary(f)
%ISBINARY

% $Id: isbinary.m,v 1.2 2005/10/11 19:02:19 fabian Exp $

if get(f, 'binary')>=0
    result = get(f, 'binary');
    return
end

result = 0;

for h = 1:len(f.header)
    hdr = f.header;
    ft = getParam(hdr(h), 'File type');
    if ~isempty(ft)
        break
    end
end

if strcmp(ft, 'Binary')
    result = 1;
end


% $Log: isbinary.m,v $
% Revision 1.2  2005/10/11 19:02:19  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:37:16  fabian
% *** empty log message ***
%

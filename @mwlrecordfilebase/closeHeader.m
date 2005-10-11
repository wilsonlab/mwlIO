function rfb = closeHeader(rfb)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 20:48:07 fabian Exp $

if nargout~=1
    warning('It is safer to provide an output argument. Aborted.')
    return;
end

nfields = size(rfb.fields,1);

fldstr = '';

for f=1:nfields
    fldstr = [fldstr sprintf('%s,%d,%d,%d\t',rfb.fields{f,1},mwltypemapping(rfb.fields{f,2}, 'str2code'),rfb.fields{f,3},rfb.fields{f,4})];
end

%remove last tab
fldstr(end)=[];

hdr = get(rfb, 'header');

if len(hdr) == 0
    sh = subheader();
else
    sh = hdr(1);
end

sh = setParam(sh, 'Fields', fldstr);

hdr(1) = sh;

rfb = set(rfb, 'header', hdr);

rfb.mwlfilebase = closeHeader(rfb.mwlfilebase);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 20:48:07  fabian
% *** empty log message ***
%

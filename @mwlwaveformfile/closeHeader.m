function wf = closeHeader(wf)
%CLOSEHEADER

% $Id: closeHeader.m,v 1.1 2005/10/09 20:51:11 fabian Exp $

hdr = get(wf, 'header');

if len(header) == 0
    sh = subheader();
else
    sh  = hdr(1);
end

sh = setParam(sh, 'File Format', 'waveform');

hdr(1) = sh;

wf = set(wf, 'header', hdr);

wf.mwlfixedrecordfile = closeHeader(wf.mwlfixedrecordfile);


% $Log: closeHeader.m,v $
% Revision 1.1  2005/10/09 20:51:11  fabian
% *** empty log message ***
%

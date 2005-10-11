function [h, hsize] = loadHeader(h, f)
%LOADHEADER

% $Id: loadHeader.m,v 1.1 2005/10/08 04:26:23 fabian Exp $

[hdr hsize] = readHeader(f);
h.subheaders = processHeader(hdr);

% $Log: loadHeader.m,v $
% Revision 1.1  2005/10/08 04:26:23  fabian
% *** empty log message ***
%

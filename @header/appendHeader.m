function h = appendHeader(h, sh)
%APPENDHEADER append subheader to header
%
%  h=APPENDHEADER(h, subhdr) append subheader object to header object.
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2
  help(mfilename)
  return
end

if ~isa(sh, 'subheader')
    error('header:appendHeader:invalidArgument', 'Invalid subheader')
end

if isempty(h.subheaders)
    h.subheaders=sh;
else
    h.subheaders(end+1) = sh;
end



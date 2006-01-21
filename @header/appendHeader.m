function h = appendHeader(h, sh)
%APPENDHEADER append subheader to header
%
%  Syntax
%
%      h = appendHeader(h, subheader)
%

%  Copyright 2005-2006 Fabian Kloosterman

if ~isa(sh, 'subheader')
    error('Can only append subheaders')
end

if isempty(h.subheaders)
    h.subheaders=sh;
else
    h.subheaders(end+1) = sh;
end



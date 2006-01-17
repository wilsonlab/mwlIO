function [h, hsize] = loadheader(f)
%LOADHEADER read and parse header from file
%
%   Syntax
%   [header, headersize] = loadheader( file )
%
%   This function will read the header from file and return a header
%   object. The parameter file can be either a file name or file identifier
%   returned by fopen.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

h = header();
[hdr hsize] = readHeader(f);

subheaders = processHeader(hdr);

h(1:length(subheaders)) = subheaders;


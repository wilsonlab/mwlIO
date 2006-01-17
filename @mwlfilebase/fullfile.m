function filename = fullfile(f)
%FULLFILE return full path to file
%
%   Syntax
%   filename = fullfile( f )
%
%   Example
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

filename = fullfile(f.path, f.filename);

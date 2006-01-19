function h = newheader(varargin)
%NEWHEADER create new subheader
%
%  Syntax
%
%    h = newheader( parameter_struct )
%    h = newheader( param1, value1, param2, value2, ... )
%
%  Description
%
%    newheader is a convenience function that creates a new subheader object
%    with parameters and corresponding values specified in a structure or as
%    parameter/value argument pairs. If you want to add comments as well,
%    use the subheader class methods instead.
%
%   Examples
%
%      s = struct('Name', 'Test', 'Version', 1);
%      h = subheader( s );
%
%      h = subheader( 'Name', 'Test', 'Version', 1);
%
%  See also SUBHEADER, HEADER
%

%  Copyright 2005-2006 Fabian Kloosterman

h = subheader();

if nargin<1
    return
end

if isstruct(varargin{1})
    
    s = varargin{1};
    
    flds = fieldnames(s);
    
    for f = 1:length(flds)
        
        h = setParam(h, flds{f}, ( s.(flds{f}) ) );
        
    end
    
    return
end

if iscell(varargin{1})
    varargin = varargin{1};
end


if mod(length(varargin),2)>0
    varargin(end) = [];
end


for f = 1:2:length(varargin)    
    h = setParam(h, varargin{f}, (varargin{f+1}));
end
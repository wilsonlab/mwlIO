function h = newheader(varargin)
%NEWHEADER create new subheader
%
%  h=NEWHEADER( param_struct ) creates an new subheader object with
%  parameter names and values specified as a structure.
%
%  h=NEWHEADER( param1, value1, ...) creates a new subheader object with
%  parameter names and values as specified in the arguments.
%
%  Note: If you want to add comments as well, use the subheader class
%  methods instead.
%
%  Example
%    h = newheader( struct('First', 1, 'Second', 'test') );
%    h = newheader( 'First', 1, 'Second', 'test' );
%
%  See also HEADER, SUBHEADER
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
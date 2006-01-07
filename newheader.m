function h = newheader(varargin)
%NEWHEADER - create new subheader

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
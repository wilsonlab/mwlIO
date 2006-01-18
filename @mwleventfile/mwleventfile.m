function ef = mwleventfile(varargin)
%MWLEVENTFILE constructor
%
%   Syntax
%   f = mwleventfile()      default constructor
%   f = mwleventfile( f )   copy constructor
%   f = mwleventfile( filename [, mode [, string_size] )
%
%   Examples
%
%   See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    ef = struct('string_size', 80);
    frf = mwlfixedrecordfile();
    ef = class(ef, 'mwleventfile', frf);
elseif isa(varargin{1}, 'mwleventfile')
    ef = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if ismember(frf.mode, {'read', 'append'})
        
        %event file?
        if ~strcmp( getFileType(frf), 'event')
            error('Not an event file')
        end
        
        fields = frf.fields;
        names = name(fields)
        if numel(fields) ~=2 | ~strcmp(names(1), 'timestamp') | ~strcmp(names(2), 'string')
            error('Invalid event file')
        end
        
        ef.string_size = length(fields(2));
        
    else
        if nargin>2 & isscalar(varargin{3}) & ~ischar(varargin{3}) & varargin{3}>0
            ef.string_size = varargin{3};
        else
            ef.string_size = 80;
        end
    end
    
    ef = class(ef, 'mwleventfile', frf);
end

function ff = mwlfeaturefile(varargin)
%MWLFEATUREFILE constructor
%
%   Syntax
%   f = mwlfeaturefile()      default constructor
%   f = mwlfeaturefile( f )   copy constructor
%   f = mwlfeaturefile( filename [, mode [, format] )
%
%   Examples
%
%   See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    ff = struct();
    frf = mwlfixedrecordfile();
    ff = class(ff, 'mwlfeaturefile', frf);
elseif isa(varargin{1}, 'mwlfeaturefile')
    ff = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if ismember(frf.mode, {'read', 'append'})
        
        %feature file?
        if ~strcmp( getFileType(frf), 'feature')
            error('Not a feature file')
        end
        
    end
    
    ff = struct();
    
    ff = class(ff, 'mwlfeaturefile', frf);
end


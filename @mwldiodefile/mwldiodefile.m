function pf = mwldiodefile(varargin)
%MWLDIODEFILE constructor
%
%   Syntax
%   f = mwldiodefile()      default constructor
%   f = mwldiodefile( f )   copy constructor
%   f = mwldiodefile( filename [, mode, format] )
%
%   Examples
%
%   See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    pf = struct();
    frf = mwlfixedrecordfile();
    pf = class(pf, 'mwldiodefile', frf);
elseif isa(varargin{1}, 'mwldiodefile')
    pf = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if ismember(frf.mode, {'read', 'append'})
        
        %diode pos file?
        if ~strcmp( getFileType(frf), 'diode')
            error('Not a diode position file')
        end
        
    end
    
    pf = struct();
    
    pf = class(pf, 'mwldiodefile', frf);
end


function bf = mwlboundfile(varargin)
%MWLBOUNDFILE constructor
%
%   Syntax
%   f = mwlboundfile()      default constructor
%   f = mwlboundfile( f )   copy constructor
%   f = mwlboundfile( filename [, mode])
%
%   Boundary files are always ascii.
%
%   Examples
%
%   See also MWLFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    bf = struct();
    base = mwlfilebase();
    bf = class(bf, 'mwlboundfile', base);
elseif isa(varargin{1}, 'mwlboundfile')
    bf = varargin{1};
else
    
    if nargin>=2
        base = mwlfilebase(varargin{1:2}, 'ascii');
    else
        base = mwlfilebase(varargin{1}, 'read', 'ascii');
    end
            

    if ~strcmp( getFileType(base), 'clbound')
        error('Not a cluster bounds file')
    end
    
    if ismember(base.format, {'binary'})
        error('Bounds file are always ascii!')
    end
    
    bf = class(struct(), 'mwlboundfile', base);
    
end
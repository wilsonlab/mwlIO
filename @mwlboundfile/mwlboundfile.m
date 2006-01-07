function bf = mwlboundfile(varargin)
%MWLBOUNDFILE

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
        base = mwlfilebase(varargin{1}, 'r', 'ascii');
    end
            
    %waveform file?
    if ~strcmp( getFileType(base), 'clbound')
        error('Not a cluster bounds file')
    end
    
    if isbinary(base)
        error('Bounds file are always ascii!')
    end
    
    bf = class(struct(), 'mwlboundfile', base);
    
end
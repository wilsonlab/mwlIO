function ff = mwlfeaturefile(varargin)
%MWLDIODEFILE

if nargin==0
    ff = struct();
    frf = mwlfixedrecordfile();
    ff = class(ff, 'mwlfeaturefile', frf);
elseif isa(varargin{1}, 'mwlfeaturefile')
    ff = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if strcmp(frf.mode, 'r')
        
        %diode pos file?
        if ~strcmp( getFileType(frf), 'pxyabw')
            error('Not a feature file')
        end
        
    end
    
    ff = struct();
    
    ff = class(ff, 'mwlfeaturefile', frf);
end


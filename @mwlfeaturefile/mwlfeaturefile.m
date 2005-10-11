function ff = mwlfeaturefile(varargin)
%MWLDIODEFILE

% $Id: mwlfeaturefile.m,v 1.1 2005/10/09 20:34:21 fabian Exp $

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


% $Log: mwlfeaturefile.m,v $
% Revision 1.1  2005/10/09 20:34:21  fabian
% *** empty log message ***
%

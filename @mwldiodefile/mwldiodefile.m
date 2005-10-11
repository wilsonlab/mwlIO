function pf = mwldiodefile(varargin)
%MWLDIODEFILE

% $Id: mwldiodefile.m,v 1.1 2005/10/09 19:54:02 fabian Exp $

if nargin==0
    pf = struct();
    frf = mwlfixedrecordfile();
    pf = class(pf, 'mwldiodefile', frf);
elseif isa(varargin{1}, 'mwldiodefile')
    pf = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if strcmp(frf.mode, 'r')
        
        %diode pos file?
        if ~strcmp( getFileType(frf), 'diode')
            error('Not a diode position file')
        end
        
    end
    
    pf = struct();
    
    pf = class(pf, 'mwldiodefile', frf);
end


% $Log: mwldiodefile.m,v $
% Revision 1.1  2005/10/09 19:54:02  fabian
% *** empty log message ***
%

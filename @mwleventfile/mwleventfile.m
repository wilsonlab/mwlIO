function ef = mwleventfile(varargin)
%MWLEVENTFILE

% $Id: mwleventfile.m,v 1.1 2005/10/09 20:32:40 fabian Exp $

if nargin==0
    ef = struct('string_size', 80);
    frf = mwlfixedrecordfle();
    ef = class(ef, 'mwleventfile', frf);
elseif isa(varargin{1}, 'mwleventfile')
    ef = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if strcmp(frf.mode, 'r')
        
        %event file?
        if ~strcmp( getFileType(frf), 'event')
            error('Not an event file')
        end
        
        fields = frf.fields;
        if size(fields, 1) ~=2 | ~strcmp(fields{1,1}, 'timestamp') | ~strcmp(fields{2,1}, 'string')
            error('Invalid event file')
        end
        
        ef.string_size = fields{2,4};
        
    else
        if nargin>2 & isscalar(varargin{3}) & ~ischar(varargin{3}) & varargin{3}>0
            ef.string_size = varargin{3};
        else
            ef.string_size = 80;
        end
    end
    
    ef = class(ef, 'mwleventfile', frf);
end
            

% $Log: mwleventfile.m,v $
% Revision 1.1  2005/10/09 20:32:40  fabian
% *** empty log message ***
%

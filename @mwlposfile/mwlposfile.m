function pf = mwlposfile(varargin)
%MWLPOSFILE

% $Id: mwlposfile.m,v 1.1 2005/10/09 20:46:47 fabian Exp $

if nargin==0
    pf = struct('currentrecord', 0, 'currentoffset', 0, 'currenttimestamp', 0, 'nrecords', 0);
    rfb = mwlrecordfilebase();
    pf = class(pf, 'mwlposfile', rfb);
elseif isa(varargin{1}, 'mwlposfile')
    pf = varargin{1};
else
    rfb = mwlrecordfilebase(varargin{:});
    
    if ~isbinary(rfb)
        error('Ascii pos files are not supported.')
    end
    
     pf.nrecords = 0;
     pf.currentrecord = 0;
     pf.currenttimestamp = 0;
     pf.currentoffset = 0;    
    
     if strcmp(rfb.mode, 'r')
        
        %rawpos file?
        if ~strcmp( getFileType(rfb), 'rawpos')
            error('Not a raw position file')
        end
        
        fields = rfb.fields;
        if size(fields, 1) ~=5 | ~strcmp(fields{1,1}, 'nitems') | ~strcmp(fields{2,1}, 'frame') | ~strcmp(fields{3,1}, 'timestamp') | ~strcmp(fields{4,1}, 'target x') | ~strcmp(fields{5,1}, 'target y')
            error('Invalid raw position file')
        end
     
        pf.nrecords = posfindrecord( fullfile( get(rfb, 'path'), get(rfb, 'filename')), get(rfb, 'headersize'), Inf );
        pf.currentoffset = get(rfb, 'headersize');

     end
     
     pf = class(pf, 'mwlposfile', rfb);
     
     if strcmp( get(pf,'mode'), 'r')
        pf = setCurrentRecord(pf, 0);
     end
     
end


% $Log: mwlposfile.m,v $
% Revision 1.1  2005/10/09 20:46:47  fabian
% *** empty log message ***
%

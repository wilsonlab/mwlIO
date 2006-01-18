function pf = mwlposfile(varargin)
%MWLPOSFILE constructor
%
%  Syntax
%
%      f = mwlposfile()      default constructor
%      f = mwlposfile( f )   copy constructor
%      f = mwlposfile( filename [, mode, format] )
%
%  See also MWLRECORDFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    pf = struct('currentrecord', 0, 'currentoffset', 0, 'currenttimestamp', 0, 'nrecords', 0);
    rfb = mwlrecordfilebase();
    pf = class(pf, 'mwlposfile', rfb);
elseif isa(varargin{1}, 'mwlposfile')
    pf = varargin{1};
else
    rfb = mwlrecordfilebase(varargin{:});
    
    if ~ismember( rfb.format, {'binary'} )
        error('Ascii pos files are not supported.')
    end
    
     pf.nrecords = 0;
     pf.currentrecord = 0;
     pf.currenttimestamp = 0;
     pf.currentoffset = 0;    
    
     if ismember( rfb.mode, {'read', 'append'})
        
        %rawpos file?
        if ~strcmp( getFileType(rfb), 'rawpos')
            error('Not a raw position file')
        end
        
        %check fields
        fields = mwlField( {'nitems', 'frame', 'timestamp', 'target x', 'target y'}, {'char', 'char', 'long', 'short', 'char'}, 1);
        if ~all( fields==rfb.fields )
            error('Invalid raw position file')
        end
     
        pf.nrecords = posfindrecord( fullfile( get(rfb, 'path'), get(rfb, 'filename')), get(rfb, 'headersize'), Inf );
        pf.currentoffset = get(rfb, 'headersize');

     end
     
     pf = class(pf, 'mwlposfile', rfb);
     
     if ismember( rfb.mode, {'read', 'append'})
        pf = setCurrentRecord(pf, 0);
     end
     
end


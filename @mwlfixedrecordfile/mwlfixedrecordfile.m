function frf = mwlfixedrecordfile(varargin)
%MWLFIXEDRECORDFILE constructor
%
%  Syntax
%
%      f = mwlfixedrecordfile()      default constructor
%      f = mwlfixedrecordfile( f )   copy constructor
%      f = mwlfixedrecordfile( filename [, mode, format] )
%
%  See also MWLRECORDFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    frf.recordsize = -1;
    frf.nrecords = -1;
    rfb = mwlrecordfilebase();
    frf = class(frf, 'mwlfixedrecordfile', rfb);
   
elseif isa(varargin{1}, 'mwlfixedrecordfile')
    frf = varargin{1};
else
    
    rfb = mwlrecordfilebase(varargin{:});
    frf.recordsize = -1;
    frf.nrecords = -1;
    
    if ismember(rfb.mode, {'read', 'append'})
        
        fields = get(rfb, 'fields');
    
        if ismember(rfb.format, {'binary'}) %if ascii, recordsize has no meaning and we can't calculate nrecords
        
            frf.recordsize = 0;
            
            frf.recordsize = sum( size(fields) );
        
            frf.nrecords = (get(rfb, 'filesize') - get(rfb, 'headersize') ) ./ frf.recordsize;
            
        end
        
    end
    
    frf = class(frf, 'mwlfixedrecordfile', rfb);
end

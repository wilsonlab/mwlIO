function frf = mwlfixedrecordfile(varargin)
%MWLFIXEDRECORDFILE

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
    
    if strcmp(rfb.mode, 'r')
        
        fields = get(rfb, 'fields');
        nfields = size(fields, 1);
        
        if isbinary(rfb) %if ascii, recordsize has no meaning and we can't calculate nrecords
        
            frf.recordsize = 0;
            
            for f=1:nfields
                frf.recordsize = frf.recordsize + fields{f,3}*fields{f,4};
            end
        
            frf.nrecords = (get(rfb, 'filesize') - get(rfb, 'headersize') ) ./ frf.recordsize;
            
        end
        
    end
    
    frf = class(frf, 'mwlfixedrecordfile', rfb);
end

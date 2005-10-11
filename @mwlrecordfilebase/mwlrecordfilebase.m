function rfb = mwlrecordfilebase(varargin)
%MWLBINARYFILE

% $Id: mwlrecordfilebase.m,v 1.2 2005/10/11 19:02:33 fabian Exp $

if nargin==0
    rfb.fields = [];
    rfb.immutable_fields = false;
    bf = mwlfilebase();
    rfb = class(rfb, 'mwlrecordfilebase', bf);
   
elseif isa(varargin{1}, 'mwlrecordfilebase')
    rfb = varargin{1};
else
    
    bf = mwlfilebase(varargin{:});
    
    if strcmp(bf.mode, 'r')
        flds = [];
        hdr = bf.header;
        for h = 1:len(hdr)  
            flds = getParam(hdr(h), 'Fields');
            if ~isempty(flds)
                break
            end
        end
        if isempty(flds)
            error('No fields parameter in header')
        end
       
        rfb.fields = processFields(flds);
        rfb.immutable_fields = false;        
    else
        rfb.fields = [];        
        rfb.immutable_fields = false;
    end
    
    rfb = class(rfb, 'mwlrecordfilebase', bf);
end


% $Log: mwlrecordfilebase.m,v $
% Revision 1.2  2005/10/11 19:02:33  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:48:56  fabian
% *** empty log message ***
%

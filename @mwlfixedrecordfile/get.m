function val = get(frf, propName)
%GET get oject properties
%
%  Syntax
%
%      value = get(f, property)
%
%  Description
%
%    Valid properties for mwlfixedrecordfile objects are (in addition to
%    those inherited from mwlrecordfilebase): 'recordsize', 'nrecords'
%
%  See also MWLFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

if strcmp( 'nrecords', propName)
    if ismember(frf.format, {'binary'})
        if ismember( fb.mode, {'read', 'append'} )    
            val = (get(frf, 'filesize') - get(frf, 'headersize') ) ./ frf.recordsize;
        else
            val = -1;
        end
    else
        val = -1;
    end
    
else
    
    try
        val = frf.(propName);
    catch
        val = get(frf.mwlrecordfilebase, propName);
    end
    
end

function retval = print( field )
%PRINT print mwlfield information in mwl header format
%
%   Syntax
%   f = print( field )
%
%   Examples
%   field = mwlfield( 'double', 1 );
%   f = print( field );
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

n = numel(field);

retval = '';

for k = 1:n
    if field(k).type==-1 || field(k).n==-1
        %skip
    else
        retval = [retval sprintf( '%s,%d,%d,%d\t', field(k).name, field(k).type, mwltypemapping(field(k).type, 'code2size'), field(k).n)];
    end
end

%remove last tab
retval(end)=[];
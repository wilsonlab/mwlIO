function retval = mwltypemapping(mwltype, mapping)
%MWLTYPE2STRING
% mwltype = value to convert
% mapping method: 'code2str', 'str2code', 'code2size', 'str2size'

% $Id: mwltypemapping.m,v 1.1 2005/10/09 21:05:27 fabian Exp $

if nargin~=2
    help(mfilename)
    return
end

map = {'char', 'short', 'int', 'float', 'double', 'func', 'ffunc', 'ulong'};
matmap = {'uint8', 'int16', 'int32', 'single', 'double', '', '', 'uint32'};
mexmap = [9, 10, 12, 7, 6, 0, 0, 13];
sizemap = [1 2 4 4 8 -1 -1 4];

switch mapping
    case 'code2str'
        if ~isscalar(mwltype)
            error('Invalid mwl type code')
        end
        if mwltype<1 | mwltype>8
            retval = 'invalid';
        else
            retval = map{mwltype};
        end
    case 'str2code'
        if ~ischar(mwltype)
            error('Invalid mwl type string')
        end
        if strcmp('long', mwltype)
            mwltype = 'ulong';
        end
        id = find( strcmp( map, mwltype ) );
        if isempty(id)
            retval = 0;
        else
            retval = id;
        end
    case 'code2size'
        if ~isscalar(mwltype)
            error('Invalid mwl type code')
        end
        if mwltype<1 | mwltype>8
            retval = -1;
        else
            retval = sizemap(mwltype);
        end        
    case 'str2size'
        if ~ischar(mwltype)
            error('Invalid mwl type string')
        end
        if strcmp('long', mwltype)
            mwltype = 'ulong';
        end        
        id = find( strcmp( map, mwltype ) );
        if isempty(id)
            retval = -1;
        else
            retval = sizemap(id);
        end        
    case 'str2mat'
        if ~ischar(mwltype)
            error('Invalid mwl type string')
        end
        if strcmp('long', mwltype)
            mwltype = 'ulong';
        end 
        id = find( strcmp( map, mwltype ) );
        if isempty(id)
            retval = '';
        else
            retval = matmap{id};
        end
    case 'str2mex'
        if ~ischar(mwltype)
            error('Invalid mwl type string')
        end
        if strcmp('long', mwltype)
            mwltype = 'ulong';
        end 
        id = find( strcmp( map, mwltype ) );
        if isempty(id)
            retval = 0;
        else
            retval = mexmap(id);
        end        
    otherwise
        error('Invalid mapping method')
end


% $Log: mwltypemapping.m,v $
% Revision 1.1  2005/10/09 21:05:27  fabian
% *** empty log message ***
%

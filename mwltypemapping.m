function retval = mwltypemapping(mwltype, mapping)
%MWLTYPEMAPPING type conversions
%
%  Syntax
%
%      new_type = mwltypemapping(type, mapping)
%
%  Description
%
%    This function will convert one type code to another type code. The
%    conversion is done according to the mapping parameter, which can be one
%    of: 'code2str', 'str2code', 'code2size', 'str2size', 'str2mat',
%    'str2mex'
%
%    List of type codes:
%      code = numeric type-code as used in mwl files
%      str = string type-code as used in mwl files
%      size = size of type
%      mat = string type code as used in matlab
%      mex = numeric type-code as used in mex files
%

%  Copyright 2005-2006 Fabian Kloosterman

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
        if ~isnumeric(mwltype) || any(mwltype<1) || any(mwltype>8)
            error('Invalid mwl type code')
        else
            retval = map(mwltype);
        end
    case 'str2code'
        if ischar(mwltype)
            mwltype = cellstr( mwltype );
        end
        if ~iscellstr(mwltype)
            error('Invalid mwl type string')
        end

        mwltype( ismember(mwltype, {'long'}) ) = {'ulong'};

        [dummy, retval] = ismember( mwltype, map );
        
        retval( retval == 0) = -1;
        
    case 'code2size'
        if ~isnumeric(mwltype) || any(mwltype<1) || any(mwltype>8)
            error('Invalid mwl type code')
        else
            retval = sizemap(mwltype);
        end        
    case 'str2size'
        if ischar(mwltype)
            mwltype = cellstr( mwltype );
        end
        if ~iscellstr(mwltype)
            error('Invalid mwl type string')
        end
        mwltype( ismember(mwltype, {'long'}) ) = {'ulong'};
           
        [dummy, retval] = ismember( mwltype, map );
        
        retval( retval == 0) = -1;
        
        retval( retval~=-1 ) = sizemap( retval( retval~=-1) );
    
    case 'str2mat'
        if ischar(mwltype)
            mwltype = cellstr( mwltype );
        end
        if ~iscellstr(mwltype)
            error('Invalid mwl type string')
        end
        mwltype( ismember(mwltype, {'long'}) ) = {'ulong'};
           
        [dummy, id] = ismember( mwltype, map );        

        retval={};
        retval( id==0 ) = {''};
        retval( id~=0 ) = matmap( id( id~=0 ) );

    case 'str2mex'
        if ischar(mwltype)
            mwltype = cellstr( mwltype );
        end
        if ~iscellstr(mwltype)
            error('Invalid mwl type string')
        end
        mwltype( ismember(mwltype, {'long'}) ) = {'ulong'};
           
        [dummy, retval] = ismember( mwltype, map );
        
        retval( retval == 0) = -1;
        
        retval( retval~=-1 ) = mexmap( retval( retval~=-1) );        
    otherwise
        error('Invalid mapping method')
end

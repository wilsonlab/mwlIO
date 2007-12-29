function retval = mwltypemapping(mwltype, mapping)
%MWLTYPEMAPPING type conversions
%
%  type_out=MWLTYPEMAPPING(type_in,mapping) maps type_in to
%  type_out according to a mapping. Valid values for mapping are:
%  'code2str', 'str2code', 'code2size', 'str2size', 'str2mat',
%  'str2mex'.
%
%  List of type codes:
%  code - numeric type code as used in mwl files
%  str - string type code as used mwl files
%  size - size of type
%  mat - string type code as used in matlab
%  mex - numeric type code as used in mex files
%
%  Table of all mappings:
%  | code |  str   | size |  mat    | mex |
%  ----------------------------------------
%  |  1   | char   |  1   |  uint8  |  9  |
%  |  2   | short  |  2   |  int16  | 10  |
%  |  3   | int    |  4   |  int32  | 12  |
%  |  4   | float  |  4   |  single |  7  |
%  |  5   | double |  8   |  double |  6  |
%  |  6   | func   | -1   |         |  0  |
%  |  7   | ffunc  | -1   |         |  0  |
%  |  8   | ulong  |  4   |  uint32 | 13  |
%  |  9   | int8   |  1   |   int8  |  8  |
%  |  10  | string |  1   |  uint8  |  9  |
%  ----------------------------------------
%
%  Example
%    mwltypemapping('short', 'str2code') %returns 2
%

%  Copyright 2005-2008 Fabian Kloosterman

if nargin~=2
    help(mfilename)
    return
end

map =    {'char',  'short', 'int',   'float',  'double', 'func', 'ffunc',  'ulong', 'int8', 'string'};
matmap = {'uint8', 'int16', 'int32', 'single', 'double',  '',     '',     'uint32', 'int8',  'uint8'};
mexmap = [  9,       10,      12,      7,        6,       0,      0,        13,       8,       9    ];
sizemap =[  1         2        4       4         8       -1      -1          4        1        1    ];

ntypes = numel(map);

switch mapping
    case 'code2str'
        if ~isnumeric(mwltype) || any(mwltype<1) || any(mwltype>ntypes)
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

        [dummy, retval] = ismember( mwltype, map ); %#ok
        
        retval( retval == 0) = -1;
        
    case 'code2size'
        if ~isnumeric(mwltype) || any(mwltype<1) || any(mwltype>ntypes)
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
           
        [dummy, retval] = ismember( mwltype, map ); %#ok
        
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
           
        [dummy, id] = ismember( mwltype, map ); %#ok
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
           
        [dummy, retval] = ismember( mwltype, map ); %#ok
        
        retval( retval == 0) = -1;
        
        retval( retval~=-1 ) = mexmap( retval( retval~=-1) );        
    otherwise
        error('Invalid mapping method')
end

if iscell(retval) && numel(retval)==1
    retval = retval{1};
end

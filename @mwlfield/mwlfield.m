function field = mwlfield(varargin)
%MWLFIELD constructor
%
%   Syntax
%   field = mwlfield()        default constructor
%   field = mwlfield( field ) copy constructor
%   field = mwlfield( name, type [, n] )
%
%   Create a new mwlfield object of specified type and name and number of
%   elements n. If n is not specified it defaults to 1. Supported types
%   are: 'char', 'short', 'int', 'float', 'double', 'func', 'ffunc',
%   'ulong'. Or their numeric equivalents 1, 2, 3, ..., 8.
%
%   Examples
%   field = mwlfield( 'pos_x', 'short', 2 )
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

if nargin==0
    field = struct('name', '', 'type', -1, 'n', -1);
    field = class( field, 'mwlfield');
elseif isa(varargin{1}, 'mwlfield')
    field = varargin{1};
else
    arg_name = varargin{1};
    if ischar(arg_name)
        n = 1;
        field.name =  varargin{1};
    elseif iscellstr(arg_name)
        n = numel(arg_name);
        [field(1:n).name] = deal( arg_name{:} );
    else
        error('Invalid field names')
    end    
    
    if nargin>1
        arg_type = varargin{2};
        if ischar(arg_type)
            arg_type = num2cell( mwltypemapping(arg_type, 'str2code') );
            [field(1:n).type] = deal( arg_type{:} );
        elseif iscellstr(arg_type) && numel(arg_type)==n
            arg_type = num2cell( mwltypemapping(arg_type, 'str2code') );
            [field(1:n).type] = deal( arg_type{:} );
        elseif isnumeric(arg_type) && ~any( arg_type<1 ) && ~any( arg_type>8 ) && ( numel(arg_type)==1 | numel(arg_type)==n )
            arg_type = num2cell( fix( arg_type ) );
            [field(1:n).type] = deal( arg_type{:} );
        else
            error('Invalid mwl type code')
        end
    end
    
    if nargin>2 && isnumeric(varargin{3}) && varargin{3}>0
        if numel(varargin{3}) == 1
            [field.n] = deal( fix(varargin{3}) );
        elseif numel(varargin{3}) == n
            [field(1:n).n] = deal( num2cell( fix( varargin{3} ) ) );
        else
            error('Invalid field size')
        end
    else
        [field.n] = deal(1);
    end
    
    field = class(field, 'mwlfield');
end
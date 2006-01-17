function [tf, loc] = ismember( A, B )
%ISMEMBER TRUE if set member
%
%   Syntax
%   [tf [, loc]] = ismember( A, B )
%
%   this function checks if the field names in A are member of the set
%   defined by B. Arguments can be either strings, cell arrays of strings
%   or mwlfield objects. The index array loc contains the highest absolute
%   index in B for each element in A which is a member of B and 0 if there
%   is no such index.
%
%   Examples
%   field = mwlfield( {'test', 'dummy'} );
%   ismember( field, {'dummy', 'test2', 'test3'} )  %will return: 
%
%   See also
%

%  Copyright 2006-2006 Fabian Kloosterman

if isa(A, 'mwlfield')
    A = {A.name};
end

if isa(B, 'mwlfield')
    B = {B.name};
end

[tf, loc] = ismember( A, B );
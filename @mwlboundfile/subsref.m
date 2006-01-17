function b = subsref(bf,s)
%SUBSREF subscripted indexing
%
%   Syntax
%   f.property
%
%   Examples
%
%   See also MWLFILEBASE
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    b = subsref(bf.mwlfilebase, s);
end
function e = eq( A, B )
%EQ equality test for mwlfield objects
%
%   Syntax
%   A == B
%
%   Examples
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

if ~isa(A, 'mwlfield') || ~isa(B, 'mwlfield')
    e = 0;
elseif numel(A) ~= numel(B)
    e = 0;
else
    for k = 1:numel(A)
        if strcmp(A(k).name, B(k).name) && A(k).type == B(k).type && A(k).n == B(k).n
            e(k) = 1;
        else
            e(k) = 0;
        end
    end
end


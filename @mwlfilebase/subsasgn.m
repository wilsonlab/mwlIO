function fb = subsasgn(fb,s, b)
%SUBSASGN subscripted assignment
%
%  Syntax
%
%      f.property = value
%

%  Copyright 2005-2006 Fabian Kloosterman

switch s.type
case '.'
    
    fb = set(fb, s.subs, b);
    
end


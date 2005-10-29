function fb = subsasgn(fb,s, b)
% SUBSREF 

switch s.type
case '.'
    
    fb = set(fb, s.subs, b);
    
end


function b = subsref(fb,s)
% SUBSREF

switch s.type
case '.'
    b = get(fb, s.subs);
end


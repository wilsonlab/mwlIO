function b = subsref(bf,s)
% SUBSREF 

switch s.type
case '.'
    b = subsref(bf.mwlfilebase, s);
end
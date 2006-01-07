function val = get(bf, propName)
%GET


try
    val = bf.(propName);
catch
    val = get(bf.mwlfilebase, propName);
end
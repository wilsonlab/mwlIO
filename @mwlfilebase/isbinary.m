function result = isbinary(f)
%ISBINARY

if get(f, 'binary')>=0
    result = get(f, 'binary');
    return
end

result = 0;

ft = getParam(f.header, 'File type');

if isempty(ft) || strcmp(ft{1}, 'Binary')
    result = 1;
end

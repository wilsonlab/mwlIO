function [h, hsize] = readHeader(f)
%READHEADER

% $Id: readHeader.m,v 1.1 2005/10/08 04:28:09 fabian Exp $

h = {};
hsize = 0;

magic_start = '%%BEGINHEADER';
magic_end = '%%ENDHEADER';

close_at_end = false;

open_files = fopen('all');

if isscalar(f) & find(open_files == f)
    %f is a file id of an open file
elseif ischar(f)
    %f is a filename
    f = fopen(f, 'r');
    close_at_end = true;
else
    error('Invalid file')
end

%store file position and go to beginning of file
fpos = ftell(f);
fseek(f, 0, 'bof');

l = fgetl(f);
if ~ischar(l) | ~strcmp(l, magic_start)
    %no recognizable header
    return
end

hsize = length(l)+1; %+1 for the new line

while 1
    l = fgetl(f);
    hsize = hsize + length(l) + 1;
    
    if strcmp(l, magic_end)
        break
    end
    
    %strip off spaces, %, and new lines
   c = find( (l ~= ' ') & (l ~= 0) & (l ~= '%') );
   l = l(min(c) : max(c));

   %store line
   
   h(end+1) = {l};
   
end

if (close_at_end)
    fclose(f);
else
    fseek(f, fpos, 'bof');
end


% $Log: readHeader.m,v $
% Revision 1.1  2005/10/08 04:28:09  fabian
% *** empty log message ***
%

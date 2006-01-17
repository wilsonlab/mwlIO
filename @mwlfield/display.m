function display( field )
%DISPLAY show field information
%
%   Syntax
%   display( field )
%
%   Examples
%
%   See also 
%

%  Copyright 2006-2006 Fabian Kloosterman

n = numel(field);
retval(1,:) = sprintf('   %10s %7s %6s', 'Name', 'Type', 'N');

for k=1:n
    retval(k+1,:) = sprintf('   %10s %7s %6d', char(field(k).name), char( type( field(k) ) ), length( field(k) ) );
end

disp( retval );
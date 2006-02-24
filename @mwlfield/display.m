function display( field )
%DISPLAY show field information
%
%  Syntax
%
%      display( field )
%

%  Copyright 2006-2006 Fabian Kloosterman

n = numel(field);
retval{1} = sprintf('   %10s %7s %4s', 'Name', 'Type', 'N');

for k=1:n
    retval{k+1} = sprintf('   %10s %7s   %s', char(field(k).name), char( type( field(k) ) ), [ '[' num2str(( field(k).n )) ']'] );
end

disp( char( retval ) );
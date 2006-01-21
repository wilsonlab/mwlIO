function retval = mex_fielddef( field )
%MEX_FIELDDEF return a field definition cell array for use in mex files
%
%  Syntax
%
%      m = mex_fielddef( field )
%


%  Copyright 2006-2006 Fabian Kloosterman

b = byteoffset( field );
m = mexcode( field  );
n = [field.n];

retval = [ b(:) m(:) n(:) ];

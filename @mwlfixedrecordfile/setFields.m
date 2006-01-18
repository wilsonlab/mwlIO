function frf = setFields(frf, fields)
%SETFIELDS create fields for new fixed record file
%
%  Syntax
%
%      f = setFields( f, fields )
%

%  Copyright 2005-2006 Fabian Kloosterman

frf.mwlrecordfilebase = setFields(frf.mwlrecordfilebase, fields);

fields = get(frf, 'fields');

frf.recordsize = sum( size(fields) );


function rfb = setFields(rfb, fields)
%SETFIELDS create fields for new record file
%
%  Syntax
%
%      f = setFields( f, fields )
%

%  Copyright 2005-2006 Fabian Kloosterman

if ~ismember(get(rfb, 'mode'), {'write', 'overwrite'})
    error('File is not in write mode')
end

if ~isa(fields, 'mwlfield')
    error('Invalid fields')
end

rfb.fields = fields;


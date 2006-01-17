function i = findRecords(f, field, bounds)
%FINDRECORDS find records
%
%   Syntax
%   i = findRecords( f, filter_field, range)
%
%   This method finds all records that meet the condition that the value of
%   the field filter_field is within the range specified. The method
%   returns a vector of record indices.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman


if nargin<3
    help(mfilename)
end

if isnumeric(bounds)
    if length(bounds)==1
        bounds = [bounds bounds];
    end
    
    data = loadField( f, field );
    
    i = find( data>=bounds(1) & data<=bounds(2) );
else
    error('Invalid bounds')
end


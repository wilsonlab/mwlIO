function data = loadrange(frf, loadflds, range, rangefield)
%LOADRANGE

% $Id: loadrange.m,v 1.1 2005/10/09 20:46:17 fabian Exp $

if nargin<3
    help(mfilename)
    return
end

try
    range = double(range);
catch
    error('Invalid range argument')
end

fields = get(frf, 'fields');

if (length(range)~=2)
    error('Range should be two element vector')
end

if ischar(loadflds)
    if strcmp(loadflds, 'all')
        loadflds = fields(:,1);
    else
        loadflds = {flds};
    end
elseif ~iscell(loadflds)
    error('Expecting cell array of field names')
end


fieldmask = 0;
for f = 1:length(loadflds)
   field_id = find(strcmp( fields(:,1), loadflds{f}));
   if field_id == 5
       field_id = 4; %just because we are treating target x and target y fields as one pos field
   end
   if ~isempty(field_id)
       fieldmask = bitor(fieldmask, 2.^(field_id-1));
   elseif strcmp(loadflds{f}, 'pos')
       fieldmask = bitor(fieldmask, 8);
   end
end

if fieldmask==0
    error('Invalid fields for loading')
end

if nargin<4 || isempty(rangefield)
    %range = record indices
    frf = setCurrentRecord(frf, range(1));
    data = posloadrecordrange( fullfile(frf), frf.currentoffset, range(2)-range(1)+1, fieldmask);
else
    fieldid = find(strcmp(fields(:,1), rangefield));
    if isempty(fieldid)
        error('Invalid range field')
    end
   %only support timestamp field
   if ~strcmp(fields{fieldid,1}, 'timestamp')
       error('Filtering only supported for timestamp field')
   end
    
   idrange = posfindtimerange(fullfile( frf ), get(frf, 'headersize'), range);
   frf = setCurrentRecord(frf, idrange(1));
   data = posloadrecordrange(fullfile( frf ), frf.currentoffset, idrange(2)-idrange(1)+1, fieldmask);

end


% $Log: loadrange.m,v $
% Revision 1.1  2005/10/09 20:46:17  fabian
% *** empty log message ***
%

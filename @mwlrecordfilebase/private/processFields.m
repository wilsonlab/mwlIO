function retval = processFields(flds)
%PROCESSFIELDS

% $Id: processFields.m,v 1.1 2005/10/09 20:50:40 fabian Exp $

if nargin<1 | ~ischar(flds)
    error('Expecting fieldstring')
end

retval = {};

if ~isempty(strfind(flds, ','))
    %assume new style field descriptors
    
    %split fields on tabs
    
    fields = strread(strtrim(flds), '%s', 'delimiter', '\t');
    
    for f = 1:length(fields)
        
        attr = strread(strtrim(fields{f}), '%s', 'delimiter', ',');
        if length(attr)~=4
            warning(['Cannot process field: ' fields{f}])
        else
            attr{2} = mwltypemapping(str2num(attr{2}), 'code2str');
            attr{3} = str2num(attr{3});
            attr{4} = str2num(attr{4});
            retval(f,1:4) = attr;
        end
        
    end
    
else
    %assume old style field descriptor
    rexp = '(?<name>[A-Za-z_]+)(?<size>\[[0-9]+\])?';
    %split on semi colon
    fields = strread(strtrim(flds), '%s', 'delimiter', ';');
    
    for f = 1:length(fields)
        
        attr = strread(strtrim(fields{f}), '%s', 'delimiter', ' ');
        if length(attr)~=2
            warning(['Cannot process field: ' fields{f}])
        else
            matches = regexp(attr{1}, rexp, 'names');
            if ~isempty(matches)
                retval{f,1} = matches.name;
                if isfield(matches, 'size')
                    retval{f,3} = strread(matches.size, '[%d]');
                else
                    retval{f,3} = 1;
                end
            end
            retval(f, 2) = attr{1};
            retval(f, 4) = {1};
         end
        
    end
end
    

% $Log: processFields.m,v $
% Revision 1.1  2005/10/09 20:50:40  fabian
% *** empty log message ***
%

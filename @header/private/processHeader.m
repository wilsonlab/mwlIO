function retval = processHeader(h)
%PROCESSHEADER

% $Id: processHeader.m,v 1.1 2005/10/08 04:28:36 fabian Exp $

if ~iscell(h)
    error('Expecting cell array of strings')
end

rexp = '(?<param>[A-Za-z]([A-Za-z0-9 [\]_])*):( |\t)+(?<value>[A-Za-z0-9 \-_:;/,.\t()[\]]+)';

linetype = 1; %new header

retval = subheader();
ch = 1;

for i=1:length(h)
    matches = regexp(h{i}, rexp, 'names');
    
    if ~isempty(matches)
        retval(end) = setParam(retval(end), matches.param, matches.value);
        linetype = 2; %parameter
    else
        th = strread(strtrim(h{i}), '%s', 'delimiter', '\n\t');
        if isempty(th) & ~(linetype==1)
            %empty line signals new header
            %but only if not preceded by empty line
            linetype = 1; %new header
            retval(end+1) = subheader();
            ch = ch+1;
        elseif ~isempty(th)
            %comment
            retval(end) = addComment(retval(end), th{1});
            linetype = 3; %comment
        end
    end
end

if len(retval(end)) == 0
    retval(end) = [];
end


% $Log: processHeader.m,v $
% Revision 1.1  2005/10/08 04:28:36  fabian
% *** empty log message ***
%

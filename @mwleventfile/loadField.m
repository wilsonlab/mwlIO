function data = loadField(ef, field, varargin)
%LOADFIELD

% $Id: loadField.m,v 1.1 2005/10/09 20:31:45 fabian Exp $

if nargin<2
    help(mfilename)
end

data = loadField(ef.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'string')]
    tmp = char(data.string);
    data.string = {};
    for i =1:size(tmp,1)
        data.string{i,1} = sprintf('%s', tmp(i,:));
    end
    data.string = deblank(data.string);    
    %data = cellstr(char(data));
end


% $Log: loadField.m,v $
% Revision 1.1  2005/10/09 20:31:45  fabian
% *** empty log message ***
%

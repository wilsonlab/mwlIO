function data = loadField(ef, field, varargin)
%LOADFIELD

% $Id: loadField.m,v 1.1 2005/10/09 20:26:59 fabian Exp $

if nargin<2
    help(mfilename)
end

data = loadField(ef.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'data')
    data = permute(reshape(data', ef.nchannels, size(data, 1)*ef.nsamples), [2 1]);
end


% $Log: loadField.m,v $
% Revision 1.1  2005/10/09 20:26:59  fabian
% *** empty log message ***
%

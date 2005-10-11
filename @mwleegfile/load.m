function data = load(ef, flds, i)
%LOAD

% $Id: load.m,v 1.1 2005/10/09 20:27:25 fabian Exp $

data = load(ef.mwlfixedrecordfile, flds, i);

if isfield(data, 'data')
    data.data = reshape(data.data', ef.nchannels, size(data.data, 1)*ef.nsamples)';
end


% $Log: load.m,v $
% Revision 1.1  2005/10/09 20:27:25  fabian
% *** empty log message ***
%

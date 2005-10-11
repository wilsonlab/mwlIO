function data = loadField(wf, field, varargin)
%LOADFIELD

% $Id: loadField.m,v 1.1 2005/10/09 20:52:01 fabian Exp $

if nargin<2
    help(mfilename)
end

data = loadField(wf.mwlfixedrecordfile, field, varargin{:});

if strcmp(field, 'waveform')
    data = permute(reshape(data, size(data, 1), wf.nchannels, wf.nsamples), [3 2 1]);
end


% $Log: loadField.m,v $
% Revision 1.1  2005/10/09 20:52:01  fabian
% *** empty log message ***
%

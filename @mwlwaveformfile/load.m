function data = load(wf, flds, i)
%LOAD

% $Id: load.m,v 1.1 2005/10/09 20:52:16 fabian Exp $

data = load(wf.mwlfixedrecordfile, flds, i);

if isfield(data, 'waveform')
    data.waveform = permute(reshape(data.waveform', wf.nchannels, wf.nsamples, size(data.waveform, 1)), [2 1 3]);
end


% $Log: load.m,v $
% Revision 1.1  2005/10/09 20:52:16  fabian
% *** empty log message ***
%

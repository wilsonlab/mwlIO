function wf = setFields(wf)
%SETFIELDS

% $Id: setFields.m,v 1.1 2005/10/09 20:52:54 fabian Exp $

if nargin>1
    warning('This file format has fixed fields. Arguments are ignored.')
end

fields = {};
fields(1,1:4) = {'timestamp' 'long' 4 1};
fields(2,1:4) = {'waveform' 'short' 2 wf.nchannels*wf.nsamples};

wf.mwlfixedrecordfile = setFields(wf.mwlfixedrecordfile, fields);


% $Log: setFields.m,v $
% Revision 1.1  2005/10/09 20:52:54  fabian
% *** empty log message ***
%

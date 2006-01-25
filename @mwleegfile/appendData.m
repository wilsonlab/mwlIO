function ef = appendData(ef, data)
%APPENDDATA append new eeg data
%
%  Syntax
%
%      f = appendData( f, data )
%
%  Description
%
%    This method appends eeg data to file f. The parameter data can be
%    any of the following: a structure with 'timestamp' and 'data'
%    fields or a two element cell array with timestamp vector and data
%    matrix. Timestamps should be a simple vector. Data should be
%    a 2-dimensional matrix of size (nsamples*nrecords) x nchannels.
%

%  Copyright 2006-2006 Fabian Kloosterman

if nargin<2 || isempty(data)
    return
end

if iscell(data) && numel(data)==2 && isnumeric(data{2}) && ndims(data{2})<=2
    
    %check if cell two contains a (nsamples*nrecords) x nchannels matrix
    
    [nsamples, nchannels] = size(data{2});
    
    nrecords = nsamples ./ ef.nsamples;
    nsamples = ef.nsamples;
    
    if ~isscalar(nrecords) || nchannels~=ef.nchannels
        error('Invalid data matrix')
    end
    
    data{2} = reshape( data{2}', nchannels.*nsamples, nrecords )';
    
    ef.mwlfixedrecordfile = appendData( ef.mwlfixedrecordfile, data);
    
elseif isstruct(data) && all( ismember( fieldnames(data), {'timestamp', 'data'} ) ) && isnumeric(data.data) && ndims(data.data)<=2
    
    [nsamples, nchannels] = size(data.data);

    nrecords = nsamples ./ ef.nsamples;
    nsamples = ef.nsamples;
    
    if ~isscalar(nrecords) || nchannels~=ef.nchannels
        error('Invalid data matrix')
    end
    
    data.data = reshape( data.data', nchannels.*nsamples, nrecords )';
    
    ef.mwlfixedrecordfile = appendData( ef.mwlfixedrecordfile, data);
    
else
    
    error('Invalid data')
    
end
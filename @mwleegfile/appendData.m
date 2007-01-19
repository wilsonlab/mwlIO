function ef = appendData(ef, data)
%APPENDDATA append new eeg data to file
%
%  f=APPENDDATA(f, data) append data to mwl eeg file. Data can be either
%  a structure with 'timestamp' and 'data' fields, or a two-element cell
%  array with timestamp and data records. Timestamps should be provided
%  as a simple vector; data should be a 2-dimensional matrix of size
%  (nsamples*nrecords) x nchannels.
%
%  Example
%    nsamples = 1808;
%    nchannels = 8;
%    nrecords = 5;
%    data = struct( 'timestamp', [1:10], ...
%                   'data', rand(nsamples*nrecords,nchannels) );
%    f = mwleegfile( 'test.eeg', 'append' );
%    f = appendData( f, data );
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
  
  if nrecords==0
    return
  end
  
  if ~isscalar(nrecords) || nchannels~=ef.nchannels
    error('mwleegfile:appendData:invalidData', 'Invalid data matrix')
  end
  
  data{2} = reshape( data{2}', nchannels.*nsamples, nrecords )';
  
  ef.mwlfixedrecordfile = appendData( ef.mwlfixedrecordfile, data);
  
elseif isstruct(data) && all( ismember( fieldnames(data), {'timestamp', 'data'} ) ) && isnumeric(data.data) && ndims(data.data)<=2
    
  [nsamples, nchannels] = size(data.data);
  
  nrecords = nsamples ./ ef.nsamples;
  nsamples = ef.nsamples;
  
  if ~isscalar(nrecords) || nchannels~=ef.nchannels
    error('mwleegfile:appendData:invalidData', 'Invalid data matrix')
  end

  if nrecords==0
    return
  end    
  
  data.data = reshape( data.data', nchannels.*nsamples, nrecords )';
  
  ef.mwlfixedrecordfile = appendData( ef.mwlfixedrecordfile, data);
    
else
    
  error('mwleegfile:appendData:invalidData', 'Invalid data')
    
end

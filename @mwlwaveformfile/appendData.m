function f = appendData(f, data)
%APPENDDATA append new waveform data to file
%
%  f=APPENDDATA(f, data) append data to mwl waveform file. Data can be either
%  a structure with 'timestamp' and 'waveform' fields, or a two-element cell
%  array with timestamp and waveform records. Timestamps should be provided
%  as a simple vector; waveform should be a 3-dimensional matrix of size
%  nsamples x nchannels x nrecords.
%

%  Copyright 2006-2006 Fabian Kloosterman

if nargin<2 || isempty(data)
    return
end

if iscell(data) && numel(data)==2 && isnumeric(data{2}) && ndims(data{2})<=3
    
    %check if cell two contains a (nsamples*nrecords) x nchannels matrix
    
    [nsamples, nchannels, nrecords] = size(data{2});
      
    if nsamples~=f.nsamples || nchannels~=f.nchannels
        error('mwlwaveformfile:appendData:invalidData', 'Invalid data matrix')
    end

    if nrecords==0
        return
    end


    data{2} = reshape( permute( data{2}, [3 2 1] ), nrecords, nsamples.*nchannels );
    
    f.mwlfixedrecordfile = appendData( f.mwlfixedrecordfile, data);
    
elseif isstruct(data) && all( ismember( fieldnames(data), {'timestamp', 'waveform'} ) ) && isnumeric(data.timestamp) && isnumeric(data.waveform) && ndims(data.waveform)<=3
    
    [nsamples, nchannels, nrecords] = size(data.waveform);
    
    if nsamples~=f.nsamples || nchannels~=f.nchannels
        error('mwlwaveformfile:appendData:invalidData', 'Invalid data matrix')
    end

    if nrecords==0
        return
    end
    

    data.waveform = reshape( permute( data.waveform, [3 2 1] ), nrecords, nsamples.*nchannels );
    
    f.mwlfixedrecordfile = appendData( f.mwlfixedrecordfile, data);
    
else
    
    error('mwlwaveformfile:appendData:invalidData', 'Invalid data')
    
end

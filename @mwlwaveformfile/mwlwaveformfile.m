function wf = mwlwaveformfile(varargin)
%MWLWAVEFORMFILE constructor
%
%  Syntax
%
%      f = mwlwaveformfile()      default constructor
%      f = mwlwaveformfile( f )   copy constructor
%      f = mwlwaveformfile( filename [, mode [, nchannels, nsamples] )
%
%  See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    wf = struct('nsamples', 0, 'nchannels', 0);
    frf = mwlfixedrecordfile();
    wf = class(wf, 'mwlwaveformfile', frf);
elseif isa(varargin{1}, 'mwlwaveformfile')
    wf = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if strcmp(frf.format, 'ascii')
        error('Ascii waveform files are not supported.')
    end    
    
    if ismember(frf.mode, {'read', 'append'})
        
        %waveform file?
        if ~strcmp( getFileType(frf), 'waveform')
            error('Not a spike waveform file')
        end
        
        fields = frf.fields;
        if ~all(ismember(name(fields), {'timestamp', 'waveform'}))
            error('Invalid waveform file')
        end  
        
        wf.nsamples = length(fields(2));
        
        wf.nchannels = 0;
        
        hdr = get(frf, 'header');
        for h=1:len(hdr)
            sh = hdr(h);
            try
                wf.nchannels = str2num(getParam(sh, 'nelect_chan'));
            catch
                continue
            end
        end
        
        if wf.nchannels == 0
            error('Cannot determine number of channels in file')
        end
        
        wf.nsamples = wf.nsamples ./ wf.nchannels;
        
    else
        
        if nargin<3
            wf.nsamples = 32;
            wf.nchannels = 4;
        elseif nargin<4
            wf.nsamples = 32;
            wf.nchannels = varargin{3};
        else
            wf.nchannels = varargin{3};
            wf.nsamples = varargin{4};
        end
        
        if ~isscalar(wf.nsamples) | ~isscalar(wf.nchannels) | ~isnumeric(wf.nchannels) | ~isnumeric(wf.nsamples)
            error('Invalid nsamples and/or nchannels parameters')
        end
        
    end
    
    wf = class(wf, 'mwlwaveformfile', frf);
    
end

function ef = mwleegfile(varargin)
%MWLEEGFILE constructor
%
%  Syntax
%
%      f = mwleegfile()      default constructor
%      f = mwleegfile( f )   copy constructor
%      f = mwleegfile( filename [, mode [, nchannels, nsamples] )
%
%  See also MWLFIXEDRECORDFILE
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    ef = struct('nsamples', 0, 'nchannels', 0);
    frf = mwlfixedrecordfile();
    ef = class(ef, 'mwleegfile', frf);
elseif isa(varargin{1}, 'mwleegfile')
    ef = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if strcmp(frf.format, 'ascii')
        error('Ascii eeg files are not supported.')
    end
    
    if ismember(frf.mode, {'read', 'append'})
        
        %eeg file?
        if ~strcmp( getFileType(frf), 'eeg')
            error('Not an eeg file')
        end
        
        fields = frf.fields;
        
        if ~all(ismember(name(fields), {'timestamp', 'data'}))
            error('Invalid eeg file')
        end        
                
        ef.nsamples = length(fields(2));
        
        ef.nchannels = 0;
        
        hdr = get(frf, 'header');
        for h=1:len(hdr)
            sh = hdr(h);
            try
                ef.nchannels = str2num(getParam(sh, 'nchannels'));
            catch
                continue
            end
        end
        
        if ef.nchannels == 0
            error('Cannot determine number of channels in file')
        end
        
        ef.nsamples = ef.nsamples ./ ef.nchannels;
        
    else
        
        if nargin<3
            ef.nsamples = 1808;
            ef.nchannels = 8;
        elseif nargin<4
            ef.nsamples = 1808;
            ef.nchannels = varargin{3};
        else
            ef.nchannels = varargin{3};
            ef.nsamples = varargin{4};
        end
        
        if ~isscalar(ef.nsamples) || ~isscalar(ef.nchannels) || ~isnumeric(ef.nchannels) || ~isnumeric(ef.nsamples)
            error('Invalid nsamples and/or nchannels parameters')
        end
        
    end
    
    ef = class(ef, 'mwleegfile', frf);
    
end

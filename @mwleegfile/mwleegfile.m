function ef = mwleegfile(varargin)
%MWLWAVEFORMFILE

% $Id: mwleegfile.m,v 1.1 2005/10/09 20:28:16 fabian Exp $

if nargin==0
    ef = struct('nsamples', 0, 'nchannels', 0);
    frf = mwlfixedrecordfile();
    ef = class(ef, 'mwlwaveformfile', frf);
elseif isa(varargin{1}, 'mwleegfile')
    wf = varargin{1};
else
    frf = mwlfixedrecordfile(varargin{:});
    
    if ~isbinary(frf)
        error('Ascii eeg files are not supported.')
    end
    
    if strcmp(frf.mode, 'r')
        
        %eeg file?
        if ~strcmp( getFileType(frf), 'eeg')
            error('Not an eeg file')
        end
        
        fields = frf.fields;
        if size(fields, 1) ~=2 | ~strcmp(fields{1,1}, 'timestamp') | ~strcmp(fields{2,1}, 'data')
            error('Invalid eeg file')
        end        
        
        ef.nsamples = fields{2,4};
        
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
        
        if ~isscalar(ef.nsamples) | ~isscalar(ef.nchannels) | ~isnumeric(ef.nchannels) | ~isnumeric(ef.nsamples)
            error('Invalid nsamples and/or nchannels parameters')
        end
        
    end
    
    ef = class(ef, 'mwleegfile', frf);
    
end


% $Log: mwleegfile.m,v $
% Revision 1.1  2005/10/09 20:28:16  fabian
% *** empty log message ***
%

function fb = mwlfilebase(varargin)
%MWLFILEBASE

% $Id: mwlfilebase.m,v 1.2 2005/10/11 19:02:19 fabian Exp $

if nargin==0
    fb.mode = '';
    fb.filename = '';
    fb.path = '';
    fb.headeropen = false;
    fb.header = header();
    fb.headersize = 0;
    fb.filesize = 0;
    fb.binary = 1;
    fb = class(fb, 'mwlfilebase');
elseif isa(varargin{1}, 'mwlfilebase')
    fb = varargin{1};
elseif nargin>3
    error('Too many arguments')
else
    if nargin==1
        filename = varargin{1};
        mode = 'r';
    else
        filename = varargin{1};
        mode = varargin{2};
        if nargin>2
            isbin = varargin{3};
        else
            isbin = 1; %binary by default
        end
    end
    
    if (~ischar(filename) | ~ischar(mode) | (~strcmp(mode, 'r') & ~strcmp(mode, 'w')) )
        error('Invalid filename and/or mode')
    end
    
    fb.mode = mode;
    fb.headersize = 0;
    fb.header = header();
    fb.headeropen = true;
    fb.filesize = 0;

    if strcmp(fb.mode, 'r')
        olddir = pwd;

        [np, nf, ne, nv] = fileparts(filename);
        if ~isempty(np)
            cd(np);
        end
        if isempty(ne)
            ne = '.'; %to make sure 'which' function works if there is no extension
        end
        filename = which([nf ne nv]);
        
        [fb.path, fb.filename, ext, versn] = fileparts(filename);
        
        cd(olddir);
        
        fb.binary = -1; %will be set later
        fb.filename = [fb.filename ext versn];
        %fb.isopen = true;
        fb.headeropen=false;
    
        fid = fopen(fullfile(fb.path, fb.filename), [fb.mode 'b']);
    
        if fid == -1
            error('Cannot open file')
        end
    
        fb.header = header();
        [fb.header fb.headersize] = loadHeader(fb.header, fid);
        
        if fb.headersize == 0
            fclose(fid);
            error('No valid header in file')
        end
        
        fseek(fid, 0, 'eof');
        fb.filesize = ftell(fid);
        fseek(fid, fb.headersize, 'bof');
                    
    else
        fid = fopen(filename, 'w');
        if fid == -1
            error('Cannot create file')
        end
        [fb.path, fb.filename, ext, versn] = fileparts(filename);
        fb.filename = [fb.filename ext versn];
        fb.binary = isbin;

    end
    
    fclose(fid);
    
    fb = class(fb, 'mwlfilebase');
    
    if strcmp(fb.mode, 'r')
        fb.binary = isbinary(fb);
    end
    
end


% $Log: mwlfilebase.m,v $
% Revision 1.2  2005/10/11 19:02:19  fabian
% *** empty log message ***
%
% Revision 1.1  2005/10/09 20:37:34  fabian
% *** empty log message ***
%

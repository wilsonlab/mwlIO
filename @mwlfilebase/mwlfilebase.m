function fb = mwlfilebase(varargin)
%MWLFILEBASE

if nargin==0
    fb.mode = '';       % r(ead) or w(rite)
    fb.filename = '';   % name of the file + extension
    fb.path = '';       % path to the file
    fb.headeropen = false;  % if header is open or closed for modification (true/false)
    fb.header = header();   % header object
    fb.headersize = 0;      % size of the header
    fb.filesize = 0;        % size of the file
    fb.binary = 1;          % binary or ascii file
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
    
    %initialize
    fb.mode = mode;
    fb.headersize = 0;
    fb.header = header();
    fb.headeropen = true;
    fb.filesize = 0;

    % if file is opened in read mode
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
        fb.headeropen=false;
    
        fid = fopen(fullfile(fb.path, fb.filename), [fb.mode 'b']);
    
        if fid == -1
            error('Cannot open file')
        end
    
        [fb.header fb.headersize] = loadHeader(fb.header, fid);
        
        if fb.headersize == 0
            fclose(fid);
            error('No valid header in file')
        end
        
        fseek(fid, 0, 'eof');
        fb.filesize = ftell(fid);
        fseek(fid, fb.headersize, 'bof');
                    
    else % if file is opened in write mode
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

function fb = mwlfilebase(varargin)
%MWLFILEBASE constructor
%
%   Syntax
%   f = mwfilebase()       default constructor
%   f = mwlfilebase( f )   copy constructor
%   f = mwlfilebase( filename [, mode, format] )
%
%   If a file name is supplied to the constructor it will open the file and
%   read the header. By default the file is opened in 'read' mode and the
%   format determined from the file header. Opening the file in 'append'
%   mode will allow data to be appended to the file. Creating a new file is
%   done by setting mode to 'write' or 'overwrite'. In the latter case if
%   the file already exists, it will be overwritten. The format parameter
%   can be set to 'binary' or 'ascii' for new files.
%
%   Examples
%
%   See also 
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin==0
    fb.mode = '';       % read, append, write or overwrite
    fb.filename = '';   % name of the file + extension
    fb.path = '';       % path to the file
    fb.header = header();   % header object
    fb.headersize = 0;      % size of the header
    fb.filesize = 0;        % size of the file
    fb.format = 'binary';   % binary or ascii file
    fb = class(fb, 'mwlfilebase');
elseif isa(varargin{1}, 'mwlfilebase')
    fb = varargin{1};
elseif nargin>3
    error('Too many arguments')
else
    % check input parameters
    if ~ischar( varargin{1})
        error('Invalid file name')
    else
        filename = varargin{1};
    end
    if nargin>1
        mode = varargin{2};
        if ~ismember(mode, {'read', 'append', 'write', 'overwrite'})
            error('Invalid mode parameter');
        end
    else
        mode = 'read';
    end
    if nargin>2 && ismember( mode, {'write', 'overwrite'} )
        isbin = varargin{3};
        if ~ismember(isbin, {'binary', 'ascii'})
            error('Invalid format parameter')
        end
    else
        isbin = 'binary';
    end
    
   
    %initialize
    fb.mode = mode;
    fb.headersize = 0;
    fb.header = header();
    fb.filesize = 0;

    % if file is opened in read mode
    if ismember(fb.mode, {'read', 'append'})
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
        
        fb.format = ''; %will be set later
        fb.filename = [fb.filename ext versn];
    
        fid = fopen(fullfile(fb.path, fb.filename), ['rb']);
    
        if fid == -1
            error('Cannot open file')
        end
    
        [fb.header fb.headersize] = loadheader(fid);
        
        if fb.headersize == 0
            fclose(fid);
            error('No valid header in file')
        end
        
        result = 0;

        fileformat = getParam(fb.header, 'File type');

        if isempty(fileformat) || strcmp(fileformat{1}, 'Binary')
            fb.format = 'binary';
        else
            fb.format = 'ascii';
        end
        
        fseek(fid, 0, 'eof');
        fb.filesize = ftell(fid);
        fseek(fid, fb.headersize, 'bof');
                    
    else % if file is opened in write mode
        if exist(filename) && ismember(fb.mode, {'write'})
            error('Error creating new file: file already exist')
        end
        
        fid = fopen(filename, 'w');
        
        if fid == -1
            error('Cannot create file')
        end
        
        [fb.path, fb.filename, ext, versn] = fileparts(filename);
        fb.filename = [fb.filename ext versn];
        fb.format = isbin;

    end
    
    fclose(fid);
    
    fb = class(fb, 'mwlfilebase');
    
end

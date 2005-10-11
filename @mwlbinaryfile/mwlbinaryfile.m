function bf = mwlbinaryfile(varargin)
%MWLBINARYFILE

% $Id: mwlbinaryfile.m,v 1.1 2005/10/09 19:51:53 fabian Exp $

if nargin==0
    bf = struct();
    fb = mwlfilebase();
    bf = class(bf, 'mwlbinaryfile', fb);
   
elseif isa(varargin{1}, 'mwlbinaryfile')
    bf = varargin{1};
else
    
    fb = mwlfilebase(varargin{:});
    if strcmp(fb.mode, 'r')
        for h = 1:len(fb.header)
            hdr = fb.header;
            ft = getParam(hdr(h), 'File type');
            if ~isempty(ft)
                break
            end
        end
        if ~strcmp(ft, 'Binary')
            error('This file is not a binary file')
        end
    end
    bf = struct();
    bf = class(bf, 'mwlbinaryfile', fb);
end


% $Log: mwlbinaryfile.m,v $
% Revision 1.1  2005/10/09 19:51:53  fabian
% *** empty log message ***
%

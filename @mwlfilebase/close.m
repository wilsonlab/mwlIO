function fb = close(fb)
%CLOSE

% $Id: close.m,v 1.1 2005/10/09 20:35:20 fabian Exp $

if nargout<1
    warning('Please supply output variable. File not closed.')
    return
end

if strcmp(fb.mode, 'w')
    
    if fb.headeropen
        fb = closeHeader(fb);
    end
    
    try
        fclose(fb.fid);
    catch
    end
    
    fb.fid = -1;
    fb.mode = 'r';
    
    fb = reopen(fb);
    
end


% $Log: close.m,v $
% Revision 1.1  2005/10/09 20:35:20  fabian
% *** empty log message ***
%

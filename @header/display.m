function display(h, c)
%DISPLAY

% $Id: display.m,v 1.1 2005/10/08 04:23:31 fabian Exp $

if nargin<2 | ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- HEADER OBJECT --'])
end

nsh = len(h);


disp(['  # subheaders: ' num2str(nsh)])

if ~(c) & len(h)>0
    disp(' ')
    disp( ['contains subheaders:'] )
    for sh=1:nsh
        display(h.subheaders(sh))
        if sh<nsh
            disp(' ')
        end
    end
end


% $Log: display.m,v $
% Revision 1.1  2005/10/08 04:23:31  fabian
% *** empty log message ***
%

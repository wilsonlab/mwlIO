function display(h, c)
%DISPLAY show information about header
%
%  Syntax
%
%      display(h [,hidetitle])
%
%  Description
%
%    This method will display the header contents. An optional title will
%    be displayed if hidetitle = 0 (default)
%

%  Copyright 2005-2006 Fabian Kloosterman

if nargin<2 || ~isscalar(c)
    c = 0;
end

if ~(c)
    disp(['-- HEADER OBJECT --'])
end

nsh = len(h);


disp(['  # subheaders: ' num2str(nsh)])

if ~(c) && len(h)>0
    disp(' ')
    disp( ['contains subheaders:'] )
    for sh=1:nsh
        display(h.subheaders(sh))
        if sh<nsh
            disp(' ')
        end
    end
end

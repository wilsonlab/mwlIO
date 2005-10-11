function t = headerType(sh)

% $Id: headerType.m,v 1.1 2005/10/09 20:55:15 fabian Exp $

%File Format field?
parm_id = find( strcmp(sh.parms(:,1), 'File Contents') );
if parm_id
    t = sh.parms{parm_id, 2};
    return
end

%Program field?
parm_id = find( strcmp(sh.parms(:,1), 'Program') );
if parm_id
    %there is a program field
    program = sh.parms{parm_id, 2};
    if findstr(program, 'adextract')
        %adextract created this file
        exparm = find( strcmp(sh.parms(:,1), 'Extraction type') );
        if exparm
            et = sh.parms{exparm, 2};
            if strcmp(et, 'event strings')
                t = 'event';
            elseif strcmp(et, 'continuous data')
                t = 'eeg';
            elseif strcmp(et, 'extended dual diode position')
                t = 'rawpos';
            elseif strcmp(et, 'tetrode waveforms')
                t = 'waveform';
            else
                t = 'unknown';
            end
        else
            t = 'unknown';
        end
    elseif findstr(program, 'posextract')
        t = 'diode';
    elseif findstr(program, 'spikeparms')
        t = 'pxyabw';
    elseif findstr(program, 'crextract')
        t = 'cr';
    elseif findstr(lower(program), 'xclust')
        if any( strcmp(sh.parms(:,1), 'Cluster') )
            t = 'cluster';
        else
            t = 'clbound';
        end
    else
        t = 'unknown';
    end
else
    adid = find( strcmp(sh.parms(:,1), 'adversion') );
    if adid
        t = ['ad ' sh.parms{adid,2}];
    else
        t = 'unknown';
    end
end


% $Log: headerType.m,v $
% Revision 1.1  2005/10/09 20:55:15  fabian
% *** empty log message ***
%

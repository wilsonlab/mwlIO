function f = mwlcreate(filename, filetype, varargin)
%MWLCREATE create a new mwl-type file
%
%  Syntax
%
%      f = mwlcreate(filename, filetype)
%
%  Description
%
%    This function will create a new mwl file object with the specified file
%    name and of the specified file type. This function currently does not
%    support 'overwrite' mode. Valid file types are:
%    'diode', 'eeg', 'event', 'feature', 'fixedrecord', 'waveform'
%
%  Options
%
%      Header = initialize header of new file with this header object
%      Data = data to save to file
%      Fields = field definition for 'feature' and 'mwlfixedrecord' files
%      FileFormat = 'ascii' or 'binary' (default = 'binary')
%


%  Copyright 2005-2006 Fabian Kloosterman


args = struct('Header', [], 'Data', [], 'Fields', {[]}, 'FileFormat', 'binary');
args = parseArgs(varargin, args);

switch filetype
    case 'diode'
        f = mwldiodefile(filename,'w', args.FileFormat);
    case 'eeg'
        f = mwleegfile(filename,'w', args.FileFormat);
    case 'event'
        f = mwleventfile(filename, 'w', args.FileFormat);
    case 'feature'
        f = mwlfeaturefile(filename, 'w', args.FileFormat);
    case 'fixedrecord'
        f = mwlfixedrecordfile(filename, 'w', args.FileFormat);
    case 'rawpos'
        %f = mwlposfile(filename, 'w');
        error 'Not implemented'
    case 'waveform'
        f = mwlwaveformfile(filename, 'w', args.FileFormat);
    case 'cluster'
        %f = mwlfixedrecordfile(filename, 'w');
        error 'Not implemented'
    otherwise
        error('Unsupported filetype')
end

%set header
if isa(args.Header, 'header')
    f = set(f, 'header', args.Header);
end

%set fields
if (strcmp(filetype, 'feature') | strcmp(filetype, 'fixedrecord') ) && ~isempty(args.Fields)
    f = setFields(f, args.Fields);
else
    f=setFields(f);
end

%write data
if ~isempty(args.Data)
    %close header
    f =closeHeader(f);    
    
    f = appendData(f, args.Data);
end

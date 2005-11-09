function f = mwlcreate(filename, filetype, varargin)

args = struct('Header', [], 'Data', [], 'Fields', {[]}, 'FileType', 'binary');
args = parseArgs(varargin, args);

b = (args.FileType(1)=='b');

switch filetype
    case 'diode'
        f = mwldiodefile(filename,'w',b);
    case 'eeg'
        f = mwleegfile(filename,'w',b);
    case 'event'
        f = mwleventfile(filename, 'w',b);
    case 'feature'
        f = mwlfeaturefile(filename, 'w',b);
    case 'fixedrecord'
        f = mwlfixedrecordfile(filename, 'w',b);
    case 'rawpos'
        %f = mwlposfile(filename, 'w');
        error 'Not implemented'
    case 'waveform'
        f = mwlwaveformfile(filename, 'w',b);
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
if strcmp(filetype, 'feature') && ~isempty(args.Fields)
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

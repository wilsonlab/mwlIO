function f = mwlcreate(filename, filetype, varargin)

args = struct('Header', [], 'Data', [], 'Fields', {[]});
args = parseArgs(varargin, args);

switch filetype
    case 'diode'
        f = mwldiodefile(filename,'w');
    case 'eeg'
        f = mwleegfile(filename,'w');
    case 'event'
        f = mwleventfile(filename, 'w');
    case 'pxyabw'
        f = mwlfeaturefile(filename, 'w');
    case 'rawpos'
        %f = mwlposfile(filename, 'w');
        error 'Not implemented'
    case 'waveform'
        f = mwlwaveformfile(filename, 'w');
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
if strcmp(filetype, 'pxyabw')
    f = setFields(f, args.Fields);
else
    f=setFields(f);
end

%close header
f =closeHeader(f);

%write data
if ~isempty(args.Data)
    f = appendData(f, args.Data);
end

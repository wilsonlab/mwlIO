function ft = getFileType(fb)
%GETFILETYPE return file type based on first subheader
%
%  Syntax
%
%      filetype = getFileType( f )
%
%  Description
%
%    This method returns the file type of mwlfilebase object f as determined
%    from the first subheader.
%
%  See also HEADER
%

%  Copyright 2005-2006 Fabian Kloosterman

if ismember(fb.mode, {'write', 'overwrite'})
    error('File is in write mode')
end

ft = headerType(fb.header(1));

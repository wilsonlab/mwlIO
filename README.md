mwlIO - Matlab and MEX functions for reading from AD files into matlab.

Installing:
Mex compiling in R2012b requires gcc-4.6, which isn't the default in Ubuntu 12.10.  There is a package for it.
``` bash
sudo apt-get install build-essential gcc-4.6
```

Call the matlab function 'makesources' from within the mwlIO folder.
mwlIO actually has to be the working directory, otherwise mex won't
find the .c sources.

``` matlab
cd PATH_TO_mwlIO/
makesources
```

<u><b>CONTENTS</b></u>

.................................................................

<b>*Opening/reading Files*</b>

<b>loadheader</b>        - read and parse header from mwl file
  
<b>mwlopen</b>           - open a mwl file

f=MWLOPEN(filename) returns a mwl file object. This function tries to determine the mwl file type from the header and returns an object of the appropriate class. Example:

    f = mwlopen( 'test.dat' );


.................................................................

<b>*Creating Files*</b>

<b>mwlcreate</b>         - create a new mwl file

f=MWLCREATE(filename, filetype) creates a new mwl file object of the specified type and with the specified file name. Valid file types are: 'diode', 'eeg', 'event', 'feature', 'fixedrecord', 'waveform'. The header of the returned mwl file object is still open and can be modified.

f=MWLCREATE(filename, filetype, param1, value1, ...) allows the caller to set additional options. Valid options are: FileFormat - 'binary' (default) or 'ascii'. Ascii format is not supported by eeg or waveform files.

Mode - 'write' or 'overwrite'.

Header - Used to set the initial header of the file object. It should be a valid header object. The option leaves the header open for modifications.

Fields - Only valid for feature and fixedrecord files whih can handle custom fields. It should be a valid mwlfield object Sets the data fields in the file.

Data - Data to be written to disk. This option will close the header.

NSamples - Only valid for eeg and waveform files. Sets the number of samples in an eeg buffer (default=1808) or in a waveform (default=32).

NChannels - Only valid for eeg and waveform files. Sets the number of channels in an eeg buffer (default=8) or in a waveform (default=4).

Example:

    f=mwlcreate('test.dat', 'eeg', 'NSamples', 1000, 'NChannels', 4);
    fields = mwlfield( {'x', 'y'}, {'short', 'short'}, 1 );
    data = struct('x', 1:100', 'y', sin(1:100)');
    f=mwlcreate('test.dat', 'feature', 'Fields', fields, 'Data', data);


.................................................................

<b>*Utilities*</b>

<b>ad_filter_convert</b> - convert ad filter setting

<b>mwltypemapping</b>    - type conversions


.................................................................

<b>*Misc*</b>

<b>makesources</b>       - compile mex files

<b>test_mwlio</b>        - test for mwlIO toolbox


.................................................................

  
See also MWLDIODEFILE, MWLEEGFILE, MWLEVENTFILE, MWLFEATUREFILE, MWLFIXEDRECORDFILE, MWLPOSFILE, MWLWAVEFORMFILE, MWLBOUNDFILE

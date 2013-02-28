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

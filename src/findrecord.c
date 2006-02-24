/* $Id: findrecord.c,v 1.1 2005/10/09 21:06:38 fabian Exp $ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <mat.h>
#include <matrix.h>
#include <mex.h>

/* function to find the records that contain a field value nearest */
/* to the requested value  - for sorted fields only!! */
/* input: file name, values, field info, record_offset, record_size*/
/* output: indices */

#define MAXSTRING 512

int compare_char(const void *key, const void *val)
{
  if ( ( *(char*)key ) < ( *(char*)val ) )
    return -1;
  else if ( ( *(char*)key ) > ( *(char*)val ) )
    return 1;
  else
    return 0;
}

int compare_double(const void *key, const void *val)
{
  if ( ( *(double*)key ) < ( *(double*)val ) )
    return -1;
  else if ( ( *(double*)key ) > ( *(double*)val ) )
    return 1;
  else
    return 0;
}

int compare_float(const void *key, const void *val)
{
  if ( ( *(float*)key ) < ( *(float*)val ) )
    return -1;
  else if ( ( *(float*)key ) > ( *(float*)val ) )
    return 1;
  else
    return 0;
}

int compare_schar(const void *key, const void *val)
{
  if ( ( *(signed char*)key ) < ( *(signed char*)val ) )
    return -1;
  else if ( ( *(signed char*)key ) > ( *(signed char*)val ) )
    return 1;
  else
    return 0;
}

int compare_short(const void *key, const void *val)
{
  if ( ( *(short*)key ) < ( *(short*)val ) )
    return -1;
  else if ( ( *(short*)key ) > ( *(short*)val ) )
    return 1;
  else
    return 0;
}

int compare_ushort(const void *key, const void *val)
{
  if ( ( *(unsigned short*)key ) < ( *(unsigned short*)val ) )
    return -1;
  else if ( ( *(unsigned short*)key ) > ( *(unsigned short*)val ) )
    return 1;
  else
    return 0;
}

int compare_long(const void *key, const void *val)
{
  if ( ( *(long*)key ) < ( *(long*)val ) )
    return -1;
  else if ( ( *(long*)key ) > ( *(long*)val ) )
    return 1;
  else
    return 0;
}

int compare_ulong(const void *key, const void *val)
{
  if ( ( *(unsigned long*)key ) < ( *(unsigned long*)val ) )
    return -1;
  else if ( ( *(unsigned long*)key ) > ( *(unsigned long*)val ) )
    return 1;
  else
    return 0;
}

void bsearch_range_file(FILE *fid, long offset, int membsize, long stride, long nmemb, void *keystart, void *keyend, int (*compar)(const void *, const void *), long *result)
{

  char *tval;
  long low, high;
  char found_start=0, found_end=0;
  long i;
  int cmp0, cmp1;

  result[0] = -1;
  result[1] = -1;

  tval =  calloc(1, membsize);

  /* compare range with first record */
  fseek(fid, offset, 0);
  fread(tval, 1, membsize, fid);

  cmp0 = compar(keystart, tval);
  cmp1 = compar(keyend, tval);
    
  if (cmp1 < 0) {
    /* end of range is before start of file, return [-1,-1] */
    found_end = 0;
    return;
  } else if (cmp0 <= 0) {
    /* start of range is before or on start of file */
    result[0] = 0;
    found_start = 1;
    if (cmp1 == 0) {
      /* end of range is beginning of file */
      result[1] = 0;
      found_end = 1;
      return;
    }
  }
  
  /* compare range with last record */
  fseek(fid, offset + (nmemb-1)*stride, 0);
  fread(tval, 1, membsize, fid);

  cmp0 = compar(keystart, tval);
  cmp1 = compar(keyend, tval);

  if (cmp0 > 0) {
    /* start of range is beyond end of file */
    found_start = 0;
    return;
  } else if (cmp1 >= 0) {
    /* end of range is beyond end of file */
    result[1] = nmemb-1;
    found_end = 1;
    if (cmp0 == 0) {
      /* start of range is end of file */
      result[0] = nmemb-1;
      found_start = 1;
      return;
    }      
  }

  if (!found_start) {
    for (low=-1, high=nmemb; high-low>1;) {
      i = (high+low)/2;
      fseek(fid, offset + i*stride, 0);
      fread(tval, 1, membsize, fid);

      cmp0 = compar(keystart, tval);

      if (cmp0 <= 0)
	high=i;
      else
	low=i;
    }
    result[0] = high;
    found_start = 1;
  }

  if (!found_end) {
    for (low=-1, high=nmemb; high-low>1;) {
      i = (high+low)/2;
      fseek(fid, offset + i*stride, 0);
      fread(tval, 1, membsize, fid);

      cmp1 = compar(keyend, tval);
  
      if (cmp1 <= 0)
	high=i;
      else
	low=i;
    }
    
    fseek(fid, offset + high*stride, 0);
    fread(tval, 1, membsize, fid);

    cmp1 = compar(keyend, tval);

    if (cmp1 == 0)
      result[1] = high;
    else
      result[1] = low;

    found_end = 1;
  }

  free(tval);
  return;
  
}


void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[] )
{
  
  char strFileName[MAXSTRING];
  double *pvalue=NULL;
  long n_values;
  double range[2];
  double *pfield=NULL;
  int byte_offset, field_type, num_elements;
  unsigned long record_offset;
  int record_size;
  FILE *fid=NULL;
  unsigned long file_size;
  long n_records;
  mxArray *output_array=NULL;
  double* ptemp;
  char *tval = NULL;
  long low, high, start_index = -1, end_index = -1;
  char found_start=0, found_end=0;
  long i;
  long result[2];
  char *rangestart, *rangeend;

  if (nrhs!=5)
    mexErrMsgTxt("Incorrect number of input arguments");

  if (!mxIsChar(prhs[0]))
    mexErrMsgTxt("First argument should be a string");

  if (!mxIsDouble(prhs[1]))
    mexErrMsgTxt("Second argument should be a double vector");

  pvalue = mxGetPr(prhs[1]);
  n_values = mxGetM(prhs[1]) * mxGetN(prhs[1]);

  if (n_values<1 || n_values>2)
    mexErrMsgTxt("Second argument should be scalar or two-element vector");

  range[0] = pvalue[0];
  range[n_values-1] = pvalue[n_values-1];

  if (!mxIsCell(prhs[2]))
    mexErrMsgTxt("Third argument should be a cell matrix of field descriptions");

  /*pfield = mxGetPr(prhs[2]);*/

  if (mxGetM(prhs[2])*mxGetN(prhs[2])!=3)
    mexErrMsgTxt("Error in field description");

  byte_offset = (int) mxGetScalar( mxGetCell( prhs[2], 0 ) );
  field_type = (int) mxGetScalar( mxGetCell( prhs[2], 1 ) );
  num_elements = (int) mxGetScalar( mxGetCell( prhs[2], 2 ) );

  if ( (num_elements>1) || mxGetNumberOfElements( mxGetCell( prhs[2], 2 ) )>1 )
    mexErrMsgTxt("Only fields with one element supported");

  if (!mxIsDouble(prhs[3]) || mxGetM(prhs[3])!=1 || mxGetN(prhs[3])!=1)
    mexErrMsgTxt("Fourth argument should be scalar");

  if (!mxIsDouble(prhs[4]) || mxGetM(prhs[4])!=1 || mxGetN(prhs[4])!=1)
    mexErrMsgTxt("Fifth argument should be scalar");

  record_offset = (unsigned long) mxGetScalar(prhs[3]);
  record_size = (int) mxGetScalar(prhs[4]);

  mxGetString(prhs[0], strFileName, MAXSTRING);
  if ( (fid = fopen(strFileName, "rb")) == NULL )
    mexErrMsgTxt("Unable to open file");

  fseek(fid, 0, 2); /* end of file */
  file_size = (unsigned long) ftell(fid);
  n_records = (long) ( (file_size - record_offset) / record_size );

  /* construct output cell array */
  output_array = mxCreateDoubleMatrix(n_values, 1, mxREAL);

  ptemp = mxGetPr(output_array);

  switch (field_type) {

  case mxCHAR_CLASS: /* char */
    rangestart = mxCalloc(sizeof(char), 1);
    *((char*)rangestart) = (unsigned long) range[0];
    rangeend = mxCalloc(sizeof(char), 1);
    *((char*)rangeend) = (char) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(char), record_size, n_records, rangestart, rangeend, compare_char, result);
    break;
  case mxDOUBLE_CLASS: /* double */
    rangestart = mxCalloc(sizeof(double), 1);
    *((double*)rangestart) = (double) range[0];
    rangeend = mxCalloc(sizeof(double), 1);
    *((double*)rangeend) = (double) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(double), record_size, n_records, rangestart, rangeend, compare_double, result);
    break;
  case mxSINGLE_CLASS: /* float */
    rangestart = mxCalloc(sizeof(float), 1);
    *((float*)rangestart) = (float) range[0];
    rangeend = mxCalloc(sizeof(float), 1);
    *((float*)rangeend) = (float) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(float), record_size, n_records, rangestart, rangeend, compare_float, result);
    break;
  case mxINT8_CLASS: /* signed char */
    rangestart = mxCalloc(sizeof(signed char), 1);
    *((signed char*)rangestart) = (signed char) range[0];
    rangeend = mxCalloc(sizeof(signed char), 1);
    *((signed char*)rangeend) = (signed char) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(signed char), record_size, n_records, rangestart, rangeend, compare_schar, result);
    break;
  case mxUINT8_CLASS: /* unsigned char */
    rangestart = mxCalloc(sizeof(unsigned char), 1);
    *((unsigned char*)rangestart) = (unsigned char) range[0];
    rangeend = mxCalloc(sizeof(unsigned char), 1);
    *((unsigned char*)rangeend) = (unsigned char) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(unsigned char), record_size, n_records, rangestart, rangeend, compare_char, result);
    break;
  case mxINT16_CLASS: /* short */
    rangestart = mxCalloc(sizeof(short), 1);
    *((short*)rangestart) = (short) range[0];
    rangeend = mxCalloc(sizeof(short), 1);
    *((short*)rangeend) = (short) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(short), record_size, n_records, rangestart, rangeend, compare_short, result);
    break;
  case mxUINT16_CLASS: /* unsigned short */
    rangestart = mxCalloc(sizeof(unsigned short), 1);
    *((unsigned short*)rangestart) = (unsigned short) range[0];
    rangeend = mxCalloc(sizeof(unsigned short), 1);
    *((unsigned short*)rangeend) = (unsigned short) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(unsigned short), record_size, n_records, rangestart, rangeend, compare_ushort, result);
    break;
  case mxINT32_CLASS: /* long */
    rangestart = mxCalloc(sizeof(long), 1);
    *((long*)rangestart) = (long) range[0];
    rangeend = mxCalloc(sizeof(long), 1);
    *((long*)rangeend) = (long) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(long), record_size, n_records, rangestart, rangeend, compare_long, result);
    break;
  case mxUINT32_CLASS: /* unsigned long */
    rangestart = mxCalloc(sizeof(unsigned long), 1);
    *((unsigned long*)rangestart) = (unsigned long) range[0];
    rangeend = mxCalloc(sizeof(unsigned long), 1);
    *((unsigned long*)rangeend) = (unsigned long) range[1];
    bsearch_range_file(fid, record_offset + byte_offset, sizeof(unsigned long), record_size, n_records, rangestart, rangeend, compare_ulong, result);
    break;

  }

  ptemp[0] = (double) result[0];
  ptemp[1] = (double) result[1];

  mxFree(tval);
  mxFree(rangestart);
  mxFree(rangeend);

  fclose(fid);
  plhs[0] = output_array;
}


/* $Log: findrecord.c,v $
/* Revision 1.1  2005/10/09 21:06:38  fabian
/* *** empty log message ***
/* */

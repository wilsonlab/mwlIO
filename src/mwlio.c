/* $Id: mwlio.c,v 1.1 2005/10/09 21:07:28 fabian Exp $ */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <mat.h>
#include <matrix.h>
#include <mex.h>

/* function to load a field from a file containing records - random access */
/* input: file name, indices, field info, record_offset, record_size*/
/* output: cell array of data*/

#define MAXSTRING 512

void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[] )
{

  char strFileName[MAXSTRING];
  FILE *fid=NULL;
  unsigned long n_id;
  unsigned long record_offset;
  unsigned long file_size;
  long n_records;
  int record_size;
  unsigned long i;
  double *pid, *ptemp;
  double *pfield;
  int id2d[2];
  int array_type;
  int n_fields;
  char *record_data;
  int j;
  int *num_elements, *byte_offset, *field_type;
  int subs;
  char **pdatatemp = NULL;

  mxArray *output_array = NULL;
  mxArray *tempArray = NULL;

  if (nrhs!=5)
    mexErrMsgTxt("Incorrect number of input arguments");

  if (!mxIsChar(prhs[0]))
    mexErrMsgTxt("First argument should be a string");

  if (!mxIsDouble(prhs[1]))
    mexErrMsgTxt("Second argument should be a vector of indices");

  pid = mxGetPr(prhs[1]);

  if (!mxIsDouble(prhs[2]))
    mexErrMsgTxt("Third argument should be a matrix of field descriptions");

  n_fields = mxGetM(prhs[2]);
  pfield = mxGetPr(prhs[2]);

  if (n_fields<1 || mxGetN(prhs[2])!=3)
    mexErrMsgTxt("Error in field descriptions");

  /* sanity checks on field descriptions */
  /* field descriptor = [ byte offset, type, number of elements ] */
  /* still to do... */

  byte_offset = (int*) mxCalloc(n_fields, sizeof(int));
  field_type = (int*) mxCalloc(n_fields, sizeof(int));
  num_elements = (int*) mxCalloc(n_fields, sizeof(int));

  for (i=0; i<n_fields; i++) {
    id2d[0]=i;
    id2d[1] = 0;
    subs = mxCalcSingleSubscript(prhs[2], 2, id2d);
    byte_offset[i] = (int) pfield[subs];
    id2d[1] = 1;
    subs = mxCalcSingleSubscript(prhs[2], 2, id2d);
    field_type[i] = (int) pfield[subs];
    id2d[1] = 2;
    subs = mxCalcSingleSubscript(prhs[2], 2, id2d);
    num_elements[i] = (int) pfield[subs];
  }

  if (!mxIsDouble(prhs[3]) || mxGetM(prhs[3])!=1 || mxGetN(prhs[3])!=1)
    mexErrMsgTxt("Fourth argument should be scalar");

  if (!mxIsDouble(prhs[4]) || mxGetM(prhs[4])!=1 || mxGetN(prhs[4])!=1)
    mexErrMsgTxt("Fifth argument should be scalar");
  
  n_id = mxGetM(prhs[1]) * mxGetN(prhs[1]);

  record_offset = (unsigned long) mxGetScalar(prhs[3]);
  record_size = (int) mxGetScalar(prhs[4]);

  mxGetString(prhs[0], strFileName, MAXSTRING);
  if ( (fid = fopen(strFileName, "rb")) == NULL )
    mexErrMsgTxt("Unable to open file");

  fseek(fid, 0, 2); /* end of file */
  file_size = (unsigned long) ftell(fid);
  n_records = (long) ( (file_size - record_offset) / record_size );

  /*mexPrintf("n_id: %ld, record_offset: %ld, record_size: %d, file_size: %ld, n_records: %d\n", n_id, record_offset, record_size, file_size, n_records);*/

  /* check indices */
  for (i=0; i<n_id; i++) {
    if (pid[i]<0 || pid[i]>n_records-1){
      fclose(fid);
      mxErrMsgTxt("Index out of bounds");
    }
  }

  /* construct output cell array */
  output_array = mxCreateCellMatrix(n_fields, 1);

  pdatatemp = (char **) mxCalloc(n_fields, sizeof(char*));

  /* construct arrays for each field */
  for(i=0; i<n_fields; i++) {
    
    mxSetCell(output_array, i, mxCreateNumericMatrix(num_elements[i], n_id, field_type[i], mxREAL));
    pdatatemp[i] = (char *) mxGetPr( mxGetCell(output_array, i) );

  }

  /*loop though index vector and retrieve records */

  record_data = (char *) mxCalloc(record_size, sizeof(char));

  for (i=0; i<n_id; i++) {

    fseek(fid, record_offset+pid[i]*record_size, 0);
    fread(record_data, 1, record_size, fid);

    /* unpack data */
    for (j=0; j<n_fields; j++) {

      switch (field_type[j]) {
	
      case mxCHAR_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(char)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(char)*num_elements[j]);
	break;
      case mxDOUBLE_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(double)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(double)*num_elements[j]);
	break;
      case mxSINGLE_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(float)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(float)*num_elements[j]);
	break;
      case mxINT8_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(signed char)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(signed char)*num_elements[j]);
	break;
      case mxUINT8_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(unsigned char)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(unsigned char)*num_elements[j]);
	break;
      case mxINT16_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(short)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(short)*num_elements[j]);
	break;
      case mxUINT16_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(unsigned short)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(unsigned short)*num_elements[j]);
	break;
      case mxINT32_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(long)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(long)*num_elements[j]);
	break;
      case mxUINT32_CLASS:
	memcpy(&(pdatatemp[j][i*sizeof(unsigned long)*num_elements[j]]), &(record_data[byte_offset[j]]), sizeof(unsigned long)*num_elements[j]);
	break;
      }



    }

  }

  mxFree(record_data);
  mxFree(byte_offset);
  mxFree(field_type);
  mxFree(num_elements);

  fclose(fid);

  plhs[0] = output_array;
}



/* $Log: mwlio.c,v $
/* Revision 1.1  2005/10/09 21:07:28  fabian
/* *** empty log message ***
/* */

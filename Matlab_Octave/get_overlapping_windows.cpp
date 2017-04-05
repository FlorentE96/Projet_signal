#include "mex.h"
#include "matrix.h"

/* The gateway routine */
extern "C"  void mexFunction(int nlhs, mxArray *plhs[],
        int nrhs, const mxArray *prhs[])
{
    
    /* nlhs : nb param entree
     * nrhs : nb param sortie
     * *plhs : sortie
    /* Get the received signal */
    unsigned lig_nbr = mxGetM(prhs[0]);
    unsigned col_nbr = mxGetN(prhs[0]);

    unsigned sig_sz = col_nbr * lig_nbr;

    
    double tmp = mxGetScalar(prhs[1]);
    if( tmp < 0.0)
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badInputFormat",
                "The window size should be be a positive integer.");
    }
    
    if ((double)(unsigned)tmp != tmp)
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badInputFormat",
                "The window size should be be a positive integer.");
    }
    
    unsigned win_sz =  (unsigned) tmp;
    
    if ( !mxIsNumeric(prhs[2]) || !mxIsScalar(prhs[2]) || mxIsComplex(prhs[2]))
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badInputFormat",
                "The number of overlap samples should be be a positive integer.");
    }
    
    tmp = mxGetScalar(prhs[2]);
    if( tmp < 0.0)
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badInputFormat",
                "The number of overlapped samples should be a positive integer.");
    }
    
    if ((double)(unsigned)tmp != tmp)
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badInputFormat",
                "The number of overlapped samples should be a positive integer.");
    }
    
    unsigned overlap = (unsigned) tmp;
    
    if (overlap >= win_sz)
    {
        mexErrMsgIdAndTxt("get_overlapping_window:badOverlapNumber",
                "The number of overlapped samples should be strictly inferior to the window size.");
    }
    
    unsigned step = win_sz - overlap;
    unsigned win_nbr = ((sig_sz - win_sz + 1)/step);
    
    if ((win_nbr-1) * step + win_sz < sig_sz)
        win_nbr++;
    
    double * y_real = mxGetPr(prhs[0]);
    
    if (mxIsComplex(prhs[0]))
    {
        double * y_imag = mxGetPi(prhs[0]);
        
        plhs[0] = mxCreateDoubleMatrix(win_sz,win_nbr, mxCOMPLEX);
        double * out_pr = mxGetPr(plhs[0]);
        double * out_pi = mxGetPi(plhs[0]);
        
        
        for (unsigned i = 0; i < win_nbr; i++)
        {
            unsigned j = 0;
            
            for (unsigned mat_idx = 0; mat_idx < win_nbr*win_sz; mat_idx++)
            {
                unsigned vec_idx = (mat_idx/win_sz)*(win_sz - overlap) + mat_idx%win_sz;
                if (vec_idx < sig_sz)
                {
                    out_pr[mat_idx] = y_real[vec_idx];
                    out_pi[mat_idx] = y_imag[vec_idx];
                }
            }
            
        }
    }
    else
    {
//         if (overlap == 0)
//         {
//             plhs[0] = mxDuplicateArray(prhs[0]);
//             mxSetM(plhs[0],win_sz);
//             mxSetN(plhs[0],win_nbr);
//         }
//         else
//         {
        plhs[0] = mxCreateDoubleMatrix(win_sz,win_nbr, mxREAL);
        double * out_pr = mxGetPr(plhs[0]);
        
        for (unsigned mat_idx = 0; mat_idx < win_nbr*win_sz; mat_idx++)
        {
            unsigned vec_idx = (mat_idx/win_sz)*(win_sz - overlap) + mat_idx%win_sz;
            if (vec_idx < sig_sz)
                out_pr[mat_idx] = y_real[vec_idx];
        }
//         }
    }
    
}

#include "stack-c.h"
#include "conv.h"
#include "ilut.h"

extern int intkrylovuzawa(char *fname)
{ 
  int mA,nA,*ia;
  int mB,nB,*ib;
  int mp,np,p;
  int msol,nsol,sol;
  int mf,nf,f;
  int moutit,noutit,outit;
  int mresdiv,nresdiv,resdiv;
  int mintit,nintit,intit;
  int mresilu,nresilu,resilu;
  int milu,nilu,ilu;
  int mdropilu,ndropilu,dropilu;
  int pierr;
  int mdt=1,ndt=1,pdt;
  int mierr=1,nierr=1,iout=6,param;  
  int iwk, *jw, *jlu, *ju , *p, *invq, ind;
  double *w,*alu, condest=1.0;
  SciSparse A;
  SciSparse B;

  param=1 + 0*2 + 1*4+ 0*8+ 1*16+ 0*32 + 0*64 + 0*128 +0*256 + 0*512;
  CheckRhs(1,9);
  CheckLhs(1,2);

  GetRhsVar(1,"s",&mA,&nA,&A);
  GetRhsVar(2,"s",&mB,&nB,&B);
  GetRhsVar(3,"d",&mp,&np,&p);
  GetRhsVar(4,"d",&msol,&nsol,&sol);
  GetRhsVar(5,"d",&mf,&nf,&f);
  GetRhsVar(6,"i",&moutit,&noutit,&outit);
  GetRhsVar(7,"d",&mresdiv,&nresdiv,&resdiv);
  GetRhsVar(8,"i",&mintit,&nintit,&intit);
  GetRhsVar(9,"d",&mresilu,&nresilu,&resilu);
  GetRhsVar(9,"i",&milu,&nilu,&ilu);
  GetRhsVar(9,"i",&mdropilu,&ndropilu,&dropilu);

  /* nb iter max */
  if (VarType(4)==1){
    GetRhsVar(4,"i",&nniter,&mniter,&niter);
    if (mniter*nniter!= 1){
      Scierror(501,"%s: niter must be a single integer \r\n",fname);
    }
  } else {
    Scierror(501,"%s: niter must be integer \r\n",fname);
    return 0;
  }
  /* reduc  res */
  if (VarType(5)==1){
    GetRhsVar(5,"d",&meps,&neps,&eps);
    if (meps*neps!= 1){
      Scierror(501,"%s: eps must be a real \r\n",fname);
    }
  } else {
    Scierror(501,"%s: init must be a real \r\n",fname);
    return 0;
  }
  /* taille de l'espace de krylov */
  if (VarType(6)==1){
    GetRhsVar(6,"i",&mkry,&nkry,&kry);
    if (mkry*nkry!= 1){
      Scierror(501,"%s: krylov must be a single integer \r\n",fname);
    }
  } else {
    Scierror(501,"%s: krylov  must be a integer \r\n",fname);
    return 0;

  }
  if (VarType(7)==1){
    GetRhsVar(7,"i",&mlfil,&nlfil,&lfil);
  } else {
    Scierror(501,"%s: lfil  must be integer \r\n",fname);
      return 0;
  }
  if (VarType(8)==1){
    GetRhsVar(8,"d",&mdt,&ndt,&pdt);
  } else {
    Scierror(501,"%s: drop must be a double \r\n",fname);
    return 0;
  }
  if (VarType(9)==1){
    GetRhsVar(9,"i",&mLU,&nLU,&LU);
      }
  CreateVar(10,"i",&mierr,&nierr,&pierr);

  iwk=(LU)*(2*(*istk(lfil))+1)+1+ (A.m-LU)*(2*(*istk(lfil))+1)+1;
  jw=(int *) malloc(21*A.m*sizeof(int));
  w= (double *) malloc(7*A.m*sizeof(double));
  p=(int *) malloc(A.m*sizeof(int));
  invq=(int *) malloc(A.m*sizeof(int));
  for(ind=0;ind<A.m;ind++){
    p[ind]=ind+1;
    invq[ind]=ind+1;
  }
  printf("iwk %i :\n",iwk);
  alu= (double *) malloc(iwk*sizeof(double));
  jlu= (int *) malloc(iwk*sizeof(int));
  ju= (int *) malloc((A.m)*sizeof(int));
  ia=Sci2spk(&A);

  
  /*
C2F(piluc)(&A.m,A.R,A.icol,ia,istk(lfil),stk(pdt),&condest,istk(LU),&param,p,invq,alu,jlu,ju,&iwk,w,jw,istk(pierr));
   */
  C2F(iluc)(&A.m,A.R,A.icol,ia,istk(lfil),stk(pdt),&param,alu,jlu,ju,&iwk,w,jw,istk(pierr));
  printf("----- fin piluc ------\n");
  free(w);
  free(jw);
  free(p);
  free(invq);

  if (*istk(pierr)!=0){
    free(ju);
    free(jlu);
    free(alu);
    if (*istk(pierr)==-1) {
      Scierror(501,"%s: input matrix may be wrong \r\n",fname);
    } else if (*istk(pierr)==-2) {
      Scierror(501,"%s: not enough memory for matrix L \r\n",fname);
    } else if (*istk(pierr)==-3) {
      Scierror(501,"%s: not enough memory for matrix U \r\n",fname);
    } else if (*istk(pierr)==-4) {
      Scierror(501,"%s: illegal value for lfil \r\n",fname);
    } else  {
      Scierror(501,"%s: zero pivot encountered at step number %d \r\n",fname,*istk(pierr));
    }
  } else {
    iwk=(A.m)*(*istk(kry)+1);
    w= (double *) malloc(iwk*sizeof(double));
    C2F(mpgmres)(&A.m,istk(LU), istk(kry), stk(b), stk(sol), w, stk(eps), istk(niter),&iout,A.R ,A.icol , ia, alu, jlu, ju, istk(pierr));
    free(w);
    free(ju);
    free(jlu);
    free(alu);
  }
  /*
  //CreateVar(10,"d",&mb,&nb,&sol);
  */
  LhsVar(1)=3;
  LhsVar(2)=10;
  return(0);
}
function [x, err, iter, flag, res] = cgs(Mat, varargin)

//  -- Iterative template routine --
//     Univ. of Tennessee and Oak Ridge National Laboratory
//     October 1, 1993
//     Details of this algorithm are described in "Templates for the
//     Solution of Linear Systems: Building Blocks for Iterative
//     Methods", Barrett, Berry, Chan, Demmel, Donato, Dongarra,
//     Eijkhout, Pozo, Romine, and van der Vorst, SIAM Publications,
//     1993. (ftp netlib2.cs.utk.edu; cd linalg; get templates.ps).
//
//  [x, err, iter, flag, res] = cgs(A, b, x, M, max_it, tol)
//
// cgs.m solves the linear system Ax=b using the 
// Conjugate Gradient Squared Method with preconditioning.
//
// input   Mat      REAL matrix or function
//         x        REAL initial guess vector
//         b        REAL right hand side vector
//         Prec     REAL preconditioner matrix or function
//         max_it   INTEGER maximum number of iterations
//         tol      REAL error tolerance
//
// output  x        REAL solution vector
//         err      REAL final residual norm
//         iter     INTEGER number of iterations performed
//         flag     INTEGER: 0 = solution found to tolerance
//                           1 = no convergence given max_it
//         res      REAL residual vector

//========================================================
//========================================================
//
//               Parsing input arguments.
//
//========================================================
//========================================================

[lhs,rhs]=argn(0);
if ( rhs== 0 ),
   error("Matrix or function is expected");
end

//--------------------------------------------------------
// Parsing of the matrix A
//--------------------------------------------------------

select type(Mat)
case 1 then
  cpt=1;
case 5 then
  cpt=1;
case 13 then
  cpt=0;
end

if (rhs == 1),
  error("cgs: please enter right hand side vector b",502);
end 

// Cas o� A est une matrice pleine ou creuse
if (cpt==1),
  if (size(Mat,1) ~= size(Mat,2)),
    error("cgs: matrix A must be square",502);
  end
  deff('y=matvec(x)','y=Mat*x');
end

// Cas o� A est une fonction
if (cpt==0),
  matvec=Mat;
end

//--------------------------------------------------------
// Parsing of the right hand side b
//--------------------------------------------------------

b=varargin(1);
if ( size(b,2) ~= 1 ),
   error("cgs: right hand side member must be a column vector",502);
end
if ( cpt==1 ),
  if ( size(b,1) ~= size(Mat,1) ),
    error("cgs: right hand side member must have the size of the matrix A",502);
  end 
end

//--------------------------------------------------------
// Parsing of the initial vector x
//--------------------------------------------------------

if (rhs >= 3),
  x=varargin(2);
  if (size(x,2) ~= 1),
    error("cgs: initial guess x0 must be a column vector",502);
  end
  if ( size(x,1) ~= size(b,1) ),
    error("cgs: initial guess x0 must have the size of b",502);
  end 
else
  x=zeros(size(b,1),1);
end

//--------------------------------------------------------
// Parsing of the preconditioner matrix M
//--------------------------------------------------------

if (rhs >=4),
  Prec=varargin(3);
  select type(Prec)
  case 1 then
    cpt=1;
  case 5 then
    cpt=1;
  case 13 then
    cpt=0;
  end 
  if ( cpt==1 ),
    if (size(Prec,1) ~= size(Prec,2)),
      error("cgs: preconditionner matrix M must be square",502);
    end 
    if ( size(Prec,1) ~= size(b,1) ),
      error("cgs: preconditionner matrix M must have the size of b",502);
    end
    deff('y=precond(x)','y=Prec \ x');
  end
  if ( cpt==0 ),
    precond=varargin(3);
  end
else
  deff('y=precond(x)','y=x');
end

//--------------------------------------------------------
// Parsing of the maximum number of iterations max_it
//--------------------------------------------------------

if (rhs >= 5),
  max_it=varargin(4);
  if (size(max_it,1) ~= 1 | size(max_it,2) ~=1),
    error("cgs: max_it must be a scalar",502);
  end 
else
  max_it=size(b,1);
end

//--------------------------------------------------------
// Parsing of the error tolerance tol
//--------------------------------------------------------

if (rhs == 6),
  tol=varargin(5);
  if (size(tol,1) ~= 1 | size(tol,2) ~=1),
    error("cgs: tol must be a scalar",502);
  end
else
  tol=1000*%eps;
end

//--------------------------------------------------------
// test about input arguments number
//--------------------------------------------------------

if (rhs > 6),
  error("cgs: too many input arguments",502);
end

//========================================================
//========================================================
//
//                Begin of computations
//
//========================================================
//========================================================

  i = 0;                               // initialization
  flag = 0;

  bnrm2 = sqrt( b'*b );
  if  ( bnrm2 == 0.0 ), bnrm2 = 1.0; end

//r = b - A*x;
  r = b - matvec(x);
  err = sqrt( r'*r ) / bnrm2;
  res = err;
  if ( err < tol ),return; end

  r_tld = r;

  for i = 1:max_it,                    // begin iteration

     rho = (r_tld'*r );
     if (rho == 0.0), break; end

     if ( i > 1 ),                     // direction vectors
        Beta = rho / rho_1;
        u = r + Beta*q;
        p = u + Beta*( q + Beta*p );
     else
        u = r;
        p = u;
     end

//   p_hat = M \ p;
     p_hat = precond(p);

//   v_hat = A*p_hat;
     v_hat = matvec(p_hat);                // adjusting scalars
     alppha = rho / ( r_tld'*v_hat );
     q = u - alppha*v_hat;

//   u_hat = M \ (u+q);
     u_hat = precond(u+q);

     x = x + alppha*u_hat;                 // update approximation

//   r = r - alppha*A*u_hat;
     r = r - alppha*matvec(u_hat);

     err = sqrt( r'*r ) / bnrm2;           // check convergence
     res = [res;err];
     if ( err <= tol ), iter=i; break, end

     rho_1 = rho;
     
     if ( i == max_it ), iter=i; end
     plot2d('nl',length(res),res($),0)
  end 

  if (err <= tol),                      // converged
     flag =  0;
  elseif ( rho == 0.0 ),                  // breakdown
     flag = -1;
  else                                    // no convergence
     flag = 1;
  end

// END cgs.sci
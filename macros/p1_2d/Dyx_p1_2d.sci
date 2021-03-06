// Copyright (C) 2011 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function A=Dyx_p1_2d(%u)
  %th=%u.geo;
  execstr('[nf,nt]=size('+%th+')');
  index=[2 3; 3 1; 1 2]';
  //------------- Calcul du déterminant ---------------------------------------
  execstr('invdet=(-1/2) ./'+%th+'.Det')
  //-------------- Assemblage -------------------------------------------------
  Tmp1=zeros(nt,1); // 1 ere fct de base
  Tmp2=zeros(nt,1); // 2 eme fcr de base
  // Tensor matrix
  A=spzeros(nf,nf);
  
  if %u.domain==[]
    for i=1:3
      // init fct de base i
      execstr('Tmp1='+%th+'.Shape_p1_Grad(i)(:,2)');
      //
      for j=1:3
	// init fonct de base j
	execstr('Tmp2='+%th+'.Shape_p1_Grad(j)(:,1)');
	
	tmp=Tmp1.*Tmp2 .*invdet;
	
	execstr('A=A+fastsparse('+%th+'.Tri(:,[i,j]),tmp,[nf,nf])');
      end
    end
  else
    for i=1:3
      // init fct de base i
      execstr('Tmp1='+%th+'.Shape_p1_Grad(i)(%u.BoolTri,2)');
      //
      for j=1:3
	// init fonct de base j
	execstr('Tmp2='+%th+'.Shape_p1_Grad(j)(%u.BoolTri,1)');
	
	tmp=Tmp1.*Tmp2 .*invdet;
	
	execstr('A=A+fastsparse('+%th+'.Tri(%u.BoolTri,[i,j]),tmp,[nf,nf])');
      end
    end
    A=A(%u.BoolNode,%u.BoolNode);
  end
  
  
endfunction


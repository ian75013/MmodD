// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function out=rgbcolor(n)
    n=n-(n-2*round(n/2))
    demi=n/2-1;
    out=[[zeros(0:demi); 0:demi ; demi:-1:0],...
	    [0:demi; demi:-1:0;zeros(0:demi)]]'/demi;
    out=out.^2;
endfunction

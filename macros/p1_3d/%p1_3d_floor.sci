// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function %in1=%p1_3d_floor(%in1)
     %in1.Node=floor(%in1.Node);
     %in1.#=rand(1);
     %in1.Id="floor("+%in1.Id+")";
endfunction
   

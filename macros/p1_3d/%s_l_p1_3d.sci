// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function %in1=%s_l_p1_3d(%s,%in1)
     %in1.Node=%s .\ %in1.Node;
     %in1.#=rand(1);
     %in1.Id=ldivf(string(%s),%in1.Id);
endfunction

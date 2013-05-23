// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function grid3d_gmv(u,G)
    // maillage structuré
   [nx,ny,nz]=size(G);
   mfprintf(u,'nodes '+string(-1)+' '...
       +string(nx)+' '+string(ny)+' '+string(nz)+'\n');
   write(u,(G.x)');
   write(u,(G.y)');
   write(u,(G.z)');
   mfprintf(u,'cells 0\n');
   
 endfunction
 

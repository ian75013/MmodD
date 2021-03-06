// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function [x]=x_grid3d_Cell(g)
//Extraction des coordonnées suivant l'axe des x d'une cellule de la grille 
//(Interpolation sur les faces)
  [nx,ny,nz]=size(g);
  barx=(g.x(1:$-1)+g.x(2:$))/2;
  x=matrix(barx(:,ones(1:(ny-1)*(nz-1))),-1,1);
endfunction

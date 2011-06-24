// Copyright (C) 2011 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function []=tri3d_plot3d(th,col)
// Mesh visualisation 
  [lhs,rhs]=argn(0);
  if rhs==1 
    col=1
  end
  n=size(th);
  index=[1 2; 2 3; 3 1]'
  
  x=[];y=[];z=[];mycolor=[];
  ed=gsort(th.Tri,'c','i');
  p=size(ed,1);
  spEdge=sparse([1 1],%f,[n,n]);
  for j=index
    spEdge=spEdge | sparse(ed(:,j),~zeros(p,1),[n,n]);
  end
  ed=spget(spEdge);
  p=size(ed,1);
  x=[x,matrix(th.Coor(ed,1),-1,2)'];
  y=[y,matrix(th.Coor(ed,2),-1,2)'];
  z=[z,matrix(th.Coor(ed,3),-1,2)'];
  mycolor=[mycolor,col(ones(1,p))];
  //f = gca();
  //f.color_map = coolcolormap(32)
  param3d1(x,y,list(z,mycolor));
  //legends(th.Id,mycolor,4)

endfunction
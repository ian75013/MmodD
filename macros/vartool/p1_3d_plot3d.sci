// Copyright (C) 2011 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function []=p1_3d_plot3d(%v,cbar,theta,alpha,leg,flag,ebox)
   // 3d boundary visalisation 
   // test inputs options 
   opts=[]
   if exists('theta','local')==1 then opts=[opts,'theta=theta'],end
   if exists('alpha','local')==1 then opts=[opts,'alpha=alpha'],end
   if exists('leg'  ,'local')==1 then opts=[opts,'leg=leg']    ,end
   if exists('flag' ,'local')==1 then opts=[opts,'flag=flag']  ,end

   
   
   my_plot3d = gcf();
   old_imdraw=my_plot3d.immediate_drawing;
   my_plot3d.immediate_drawing="off"

   // test if the color map is a standard one (suppose to be of size 32)
   if size(my_plot3d.color_map,1)==32
     coulmax=256;
     my_plot3d.color_map=jetcolormap(coulmax);
   else
     coulmax=size(my_plot3d.color_map,1);
   end
   
   // mesh
  %th=evstr(%v.geo);
  %nbd=length(%th.Bnd)
  if exists('ebox' ,'local')==1  
    opts=[opts,'ebox=ebox'] 
  else
    x_min=min(%th);
    x_max=max(%th);
    ebox=matrix([x_min,x_max]',-1,1)'
    opts=[opts,'ebox=ebox'];
  end
  
  // color and colorbar
  mi=min(%v.Node); ma=max(%v.Node);
  if  exists('cbar','local')==1
    if cbar=="on"
      colorbar(mi,ma);
    end
  end
  
  for fr=%th.BndId
    // Note optimal but it work
    Tri=%th(fr);
    xx=matrix(%th.Coor(Tri,1),-1,3)';
    yy=matrix(%th.Coor(Tri,2),-1,3)';
    zz=matrix(%th.Coor(Tri,3),-1,3)';
    coul=matrix(%v.Node(Tri),-1,3)';
    if mi~=ma
      coul=round((coulmax-1)*(coul-mi)/(ma-mi))+1;
    else
      coul=round(coulmax/2)*ones(coul(1,:));
    end
    execstr('plot3d(xx,yy,list(zz,coul),'+strcat(opts,',')+')');
    my_gca=gca();
    my_gca.hiddencolor=-1;
  end  

  my_plot3d.immediate_drawing=old_imdraw
endfunction

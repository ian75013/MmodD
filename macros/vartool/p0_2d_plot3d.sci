// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function p0_2d_plot3d(%v)
    %th=evstr(%v.geo);
    mi=min(%v.Cell); ma=max(%v.Cell);
    rect =[min(%th);mi;max(%th);ma]';
    flag=[2,1,4];
    ebox=rect([1 4 2 5 3 6]);
    xx=matrix(%th.Coor(%th.Tri,1),-1,3)';
    yy=matrix(%th.Coor(%th.Tri,2),-1,3)';
    zz=%v.Cell(:,[1 1 1])';
 
    coulmax=256;
    f=gcf()  
    f.color_map = jetcolormap(256)
    colorbar(mi,ma);
    coul=zz(1,:)
    if mi~=ma
      coul=round((coulmax-1)*(coul-mi)/(ma-mi))+1;
    else
      coul=round(coulmax/2)*ones(coul(1,:));
    end
    
   // plot3d1([xx xx($:-1:1,:)],[yy yy($:-1:1,:)],..
	//[zz,zz($:-1:1,:)],flag=flag,ebox=ebox)
    plot3d([xx xx($:-1:1,:)],[yy yy($:-1:1,:)],..
	list([zz,zz($:-1:1,:)],[coul,coul($:-1:1,:)]),flag=flag,ebox=ebox)
    //plot3d(xx,yy,list(zz,coul),flag=[0,0,0]);
    //plot3d1(xx,yy,list(zz,coul),flag=flag,ebox=ebox)
    //plot3d1(xx,yy,zz,flag=[0,0,0])
 
    xtitle(name_mmodd(%v)+' : '+%v.Id)
    
    m=uimenu('label','2d View');
    m1=uimenu(m,'label','Turn in 2d','callback','p0_2d_plot2d('+name_mmodd(%v)+')')
    
endfunction
  

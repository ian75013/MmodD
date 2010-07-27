// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

l1  = list('Drawing Mode',1,['Square2d','Graphic Mode']);

rep = x_choices('2D Geometry Definition',list(l1));


if rep==1
  temp=x_mdialog('square2d definition',[['x';'y']],[['number_points','origin_plot']],string([4 0;4 0]));
  nxy=evstr([temp(1),temp(2)]);
  xy=evstr([temp(1,2),temp(2,2)]);
  th=square2d(nxy(1),nxy(2));
  th.Coor(:,1)=th.Coor(:,1)+xy(1);
  th.Coor(:,2)=th.Coor(:,2)+xy(2);
  disp(' --- Square2d Built ---')
//else
//  disp('  --- Launching graphic mode ---');
end
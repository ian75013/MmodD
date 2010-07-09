function []=mesh_tool(%n)
  disp("affichage boutons")
 rac=evstr('typeof('+%_nams(%n)+')');
  
  Number='Number';
  Geom='Geom';
  Replot='Replot';
  File='File';
  troisD='3D Rot.';
  // nouvelle fenetre
  gwin=(max(winsid())+1);
  xset('window',gwin);
  //gwin=xget("window");
  // Menu deja existant par defaut  
  delmenu(gwin,'Edit') 
  //delmenu(gwin,'3D Rot.') //2d seulement
  //unsetmenu(gwin,'File',7) //close'=Objects')  
  etat=[%f;%f;%f;%t;%t;%f]; // etat d'affichage :voir node, triangles et extremes
  
  menu_mesh_disp(gwin,etat); // affichage du Menu

  // Commande associe au Menu Meshtool
  execstr(Number+'_'+string(gwin)+...
	  '=[''etat(1)=~etat(1); if etat(1) then, '+rac+'_show_node('+%_nams(%n)+') ,end;... 
	  menu_mesh_disp(gwin,etat);'';...
	  ''etat(2)=~etat(2); if etat(2) then, '+rac+'_show_cell('+%_nams(%n)+') ,end;... 
	  menu_mesh_disp(gwin,etat);'';...
	  ''etat(3)=~etat(3); if etat(3) then, '+rac+'_show_face('+%_nams(%n)+') ,end;...  
	  menu_mesh_disp(gwin,etat);'']');
  
  // Commandes associes a Geom
  execstr(Geom+'_'+string(gwin)+...
          '=[''etat(4)=~etat(4); if etat(4) then, '+rac+'_plot('+%_nams(%n)+') ,end;...  
	  menu_mesh_disp(gwin,etat);'';...
	  ''etat(5)=~etat(5); if etat(5) then, '+rac+'_show_bnd('+%_nams(%n)+') ,end;...  
	  menu_mesh_disp(gwin,etat);'';...
	  ''etat(6)=~etat(6); if etat(6) then, '+rac+'_show_rect('+%_nams(%n)+') ,end;...  
	  menu_mesh_disp(gwin,etat);'']')
  // Commande associe au Replot
   execstr(Replot+'_'+string(gwin)+...
	  '=''mesh_disp('+%_nams(%n)+',etat);''');
   execstr('mesh_disp('+%_nams(%n)+',etat)');
 
endfunction
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// gestion du menu meshtools
function []=mesh_disp(th,etat)
  clf();
  rect =[min(th)-0.05*abs(max(th)-min(th));max(th)+0.05*abs(max(th)-min(th))]';
  
  plot2d(1,1,[1],"030"," ",rect(1:4));
  mesh_view()
  
  if etat(4) then execstr(rac+'_plot(th)'), end
  if etat(5) then execstr(rac+'_show_bnd(th)'), end
  if etat(1) then execstr(rac+'_show_node(th)'), end
  if etat(2) then execstr(rac+'_show_cell(th)'), end
  if etat(3) then execstr(rac+'_show_face(th)'), end
  if etat(6) then execstr(rac+'_show_rect(th)'), end

endfunction

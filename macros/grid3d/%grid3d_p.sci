// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

function %grid3d_p(G)
  write(%io(2),'Type grid3d : '+G.id+'  '+string(length(G.x))...
      +'x'+string(length(G.y)) +'x'+string(length(G.z)))
  write(%io(2),' ');
  write(%io(2),'    xmin = '+string(min(G.x))+'  xmax = '+ ...
      string(max(G.x)));
  write(%io(2),'    ymin = '+string(min(G.y))+'  ymax = '+ ...
      string(max(G.y)));
  write(%io(2),'    zmin = '+string(min(G.z))+'  zmax = '+ ...
      string(max(G.z)));
endfunction

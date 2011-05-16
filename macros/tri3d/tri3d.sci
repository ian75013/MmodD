function th=tri3d(varargin)
// declaration de type
//-----------------------------------------------------------
// type mesh
//----------
//    id : identite
//    Coor : tableau des coordonnees des points du maillage colones en lignes
//    Tri  : tableau des indices de triangles (sens positif) 
//    BndId : table des noms fronti�res
//    BndNode : liste des indices des points frontiere
    [lhs,rhs]=argn(0);
    Id="";Coor=[];Tri=[];
    if rhs==1
      Id=varargin(1);
    else
      Tri=varargin(1)(varargin(2));
      tmp=unique(Tri);
      Coor=varargin(1).Coor(tmp,:);
      tmp2=spzeros(max(tmp),1);
      tmp2(tmp)=(1:length(tmp))'
      Tri=matrix(full(tmp2(Tri)),-1,3)
    end
    
    th=mlist(['tri3d';'#';'Id';'Coor';'Tri';'BndId';'Bnd';'BndPerio'],...
	rand(),Id,Coor,Tri,[],list(),[])
    
endfunction
// Copyright (C) 2011 - Thierry Clopeau
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution. The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

demopath = get_absolute_file_path("react.dem.gateway.sce");
subdemolist = ["Black","black.sce";..
	       "Bi color","bicolor.sce";..
	       "Small patterns","smallpatterns.sce";...
	       "Medium patterns","mediumpatterns.sce";...
	       "Big patterns","bigpatterns.sce"];

subdemolist(:,2) = demopath + subdemolist(:,2);
clear demopath;

// Copyright (C) 2010 - Thierry Clopeau
// 
// This file must be used under the term of the CeCILL
// http://www.cecill.info 

sci_gateway_dir = get_absolute_file_path('builder_gateway.sce');

tbx_builder_gateway_lang('c', sci_gateway_dir);


 //LCC does not manage C++
//if ~with_lcc() then
//  tbx_builder_gateway_lang('cpp', sci_gateway_dir); 
//  languages = ['c', 'fortran','cpp'];
//else
//  languages = ['c', 'fortran'];
//end

languages = ['c'];
tbx_build_gateway_loader(languages, sci_gateway_dir);
tbx_build_gateway_clean(languages, sci_gateway_dir);

clear tbx_builder_gateway_lang tbx_build_gateway_loader;
clear sci_gateway_dir;

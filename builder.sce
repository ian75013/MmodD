// Copyright (C) 2010-11 - Thierry Clopeau
// Copyright (C) 2010 - Delanoue David
// Copyright (C) 2010 - Marcel Ndeffo
// Copyright (C) 2010 - Sofian Smatti
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution. The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt


mode(-1);
lines(0);

TOOLBOX_NAME  = "MmodD";
TOOLBOX_TITLE = "Modular Modeling";
toolbox_dir = get_absolute_file_path("builder.sce");

// Check Scilab's version
// =============================================================================

try
	v = getversion("scilab");
catch
	error(gettext("Scilab 5.2 or more is required."));
end

if v(2) < 2 then
	// new API in scilab 5.2
	error(gettext('Scilab 5.2 or more is required.'));  
end

// Check development_tools module avaibility
// =============================================================================

if ~with_module('development_tools') then
  error(msprintf(gettext('%s module not installed.'),'development_tools'));
end

// Action
// =============================================================================

exec(toolbox_dir+'\macros\buildmacros.sce');
// sources compilation ...
// to be remove before SCILAB 6.0
setenv("__USE_DEPRECATED_STACK_FUNCTIONS__", "YES");

tbx_builder_src(toolbox_dir);
tbx_builder_gateway(toolbox_dir);
tbx_builder_help(toolbox_dir);
tbx_build_loader(TOOLBOX_NAME, toolbox_dir);
tbx_build_cleaner(TOOLBOX_NAME, toolbox_dir);

// Clean variables
// =============================================================================

//clear toolbox_dir TOOLBOX_NAME TOOLBOX_TITLE;

// Exit after compilation
exit
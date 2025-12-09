if v:version < 900
  finish
endif

lua require("obsess").setup()
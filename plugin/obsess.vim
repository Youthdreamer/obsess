if v:version < 1000
  finish
endif

lua require("obsess").setup()
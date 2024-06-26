{ lib, ... }:
{
  keymaps = [
    { mode = "n"; key = "<C-k>"; options.silent = true; action = ":BufferNext<CR>"; }
    { mode = "n"; key = "<C-j>"; options.silent = true; action = ":BufferPrevious<CR>"; }
    { mode = "n"; key = "<C-q>"; options.silent = true; action = ":BufferClose<CR>"; }
    { mode = "n"; key = "<A-0>"; options.silent = true; action = ":BufferLast<CR>"; }
    { mode = "n"; key = "<leader>e"; options.silent = true; action = ":Telescope file_browser<CR>"; }
  ] ++ (map
    (i: { mode = "n"; key = "<A-${toString i}>"; options.silent = true; action = ":BufferGoto ${toString i}<CR>"; })
    (lib.lists.range 1 9)
  );
}

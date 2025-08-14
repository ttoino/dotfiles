{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  # TODO
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.catppuccin.enable = true;
    colorscheme = "catppuccin";
  };
}

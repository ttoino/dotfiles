{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh = {
    promptInit = builtins.readFile ./prompt.zsh;
    interactiveShellInit = ''
      ${builtins.readFile ./functions.zsh}
      ${builtins.readFile ./keybinds.zsh}
      ${builtins.readFile ./opts.zsh}
      ${builtins.readFile ./completion.zsh}
    '';
  };
}

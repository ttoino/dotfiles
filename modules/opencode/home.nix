{ config, pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    web.enable = true;

    settings = {
      model = "opencode-go/moonshotai/kimi-k2.5";
      permission.edit = "ask";
      provider.opencode-go.options.apiKey = "{file:${
        builtins.replaceStrings [ "\${" ] [ "{env:" ] config.age.secrets.opencode-go-api-key.path
      }}";
      server = {
        port = 9090;
        hostname = "127.0.0.1";
      };
    };

    skills =
      let
        anthropic = pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "skills";
          rev = "98669c11ca63e9c81c11501e1437e5c47b556621";
          hash = "sha256-w//9LB1OVG9jlllY+VDse7Js0dn5x6Ys2vPuQACKsTM=";
        };
      in
      {
        frontend-design = anthropic + "/skills/frontend-design";
        skill-creator = anthropic + "/skills/skill-creator";
      };
  };

  age.secrets.opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
}

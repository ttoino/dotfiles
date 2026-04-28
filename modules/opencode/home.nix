{ config, pkgs, ... }:
{
  programs.opencode = {
    enable = true;

    web = {
      enable = true;
      extraArgs = [
        "--port=9090"
        "--hostname=0.0.0.0"
      ];
    };

    settings = {
      mcp = {
        github = {
          enabled = false;
          type = "remote";
          url = "https://api.githubcopilot.com/mcp/";
        };
        nix = {
          enabled = false;
          type = "local";
          command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
        };
      };
      model = "opencode-go/moonshotai/kimi-k2.6";
      permission.edit = "ask";
      provider.opencode-go.options.apiKey = "{file:${
        builtins.replaceStrings [ "\${" ] [ "{env:" ] config.age.secrets.opencode-go-api-key.path
      }}";
    };

    skills =
      let
        anthropic = pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "skills";
          rev = "98669c11ca63e9c81c11501e1437e5c47b556621";
          hash = "sha256-w//9LB1OVG9jlllY+VDse7Js0dn5x6Ys2vPuQACKsTM=";
        };
        cloudflare = pkgs.fetchFromGitHub {
          owner = "cloudflare";
          repo = "skills";
          rev = "0438a075b419f737eb091d1c91800b7387e3a75f";
          hash = "sha256-dPMZCgE+nLWfZgvIKiZ33LYb2zJaunF/mv2SiCUHSNM=";
        };
      in
      {
        cloudflare = cloudflare + "/skills/cloudflare";
        frontend-design = anthropic + "/skills/frontend-design";
        skill-creator = anthropic + "/skills/skill-creator";
        wrangler = cloudflare + "/skills/wrangler";
      };
  };

  age.secrets.opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
}

{
  config,
  inputs,
  pkgs,
  ...
}:
let
  peon-ping = inputs.peon-ping.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [ inputs.peon-ping.homeManagerModules.default ];

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

  xdg.configFile."opencode/plugins/peon-ping.ts".source = pkgs.runCommand "peon-ping.ts" { } ''
    cp ${
      inputs.peon-ping.packages.${pkgs.stdenv.hostPlatform.system}.default
    }/share/peon-ping/adapters/opencode/peon-ping.ts $out

    sed -i '/const PEON_SH_PATHS = \[/a\  path.join(os.homedir(), ".openpeon", "peon.sh"),' $out
  '';

  programs.peon-ping = {
    enable = true;
    package = peon-ping;

    settings = {
      default_pack = "eve-walle";
      volume = 0.5;
      pack_rotation = [
        "dva"
        "eve-walle"
        "glados"
        "jarvis-mk2"
        "minecraft-villager"
        "ocarina_of_time"
      ];
    };

    installPacks = [
      "glados"
      "ocarina_of_time"

      {
        name = "dva";
        src = pkgs.fetchFromGitHub {
          owner = "leo-rutter";
          repo = "d.va-pack";
          rev = "v1.0.0";
          hash = "sha256-YM4ge0j0HaZl1PMtmngx4qf1fJHLmr825bweezO5ZLQ=";
        };
      }
      {
        name = "eve-walle";
        src = pkgs.fetchFromGitHub {
          owner = "stphnlngdncoding";
          repo = "eve-walle";
          rev = "v1.0.1";
          hash = "sha256-ujwutbgkY+DxEOJQeu0APuSgVWBLJj51N3kJEE/vmfM=";
        };
      }
      {
        name = "jarvis-mk2";
        src = pkgs.fetchFromGitHub {
          owner = "FlynnCruse";
          repo = "openpeon-jarvis";
          rev = "v1.1.0";
          hash = "sha256-SDelu1fhg2/JFKIQM4lSLevl7wMUBfuAFNOM/5gf8Mo=";
        };
      }
      {
        name = "minecraft_villager";
        src = pkgs.fetchFromGitHub {
          owner = "Mahamurahti";
          repo = "openpeon-minecraft-villager";
          rev = "v1.0.1";
          hash = "sha256-0vyWcgbdFcFwke8zSX3GSPETRX4fufeEXE2Dmks/9YE=";
        };
      }
    ];
  };

  age.secrets.opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
}

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
        anthropic = pkgs.sources.anthropic-skills.src;
        cloudflare = pkgs.sources.cloudflare-skills.src;
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
        src = pkgs.sources.peon-dva.src;
      }
      {
        name = "eve-walle";
        src = pkgs.sources.peon-eve-walle.src;
      }
      {
        name = "jarvis-mk2";
        src = pkgs.sources.peon-jarvis-mk2.src;
      }
      {
        name = "minecraft_villager";
        src = pkgs.sources.peon-minecraft-villager.src;
      }
    ];
  };

  age.secrets.opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
}

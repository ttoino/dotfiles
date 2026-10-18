{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  peon-ping = inputs.peon-ping.packages.${pkgs.stdenv.hostPlatform.system}.default;

  toOpencodeEnvPath = secret: "{file:${builtins.replaceStrings [ "\${" ] [ "{env:" ] secret.path}}";
  toSystemdRuntimePath =
    secret: builtins.replaceStrings [ "\${XDG_RUNTIME_DIR}" ] [ "%t" ] secret.path;
in
{
  imports = [ inputs.peon-ping.homeManagerModules.default ];

  programs.opencode = {
    enable = true;
    context = ./AGENTS.md;
    extraPackages = with pkgs; [ systemd ];

    web = {
      enable = true;
      extraArgs = [
        "--port=9090"
        "--hostname=0.0.0.0"
      ];
      environmentFile = null;
    };

    settings = {
      mcp = {
        github = {
          enabled = false;
          type = "remote";
          url = "https://api.githubcopilot.com/mcp";
        };
        material = {
          enabled = false;
          type = "remote";
          url = "https://material.mcp.toino.pt/mcp";
          timeout = 600000;
        };
        nix = {
          enabled = false;
          type = "local";
          command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
        };
      };
      model = "opencode-go/moonshotai/kimi-k2.7-code";
      permission.edit = "ask";
      plugin = [ "opencode-sleep-inhibitor" ];
      provider = {
        cloudflare-ai-gateway.options = {
          accountId = "e024e5a1e487a3d3a07815b431986107";
          gatewayId = "opencode";
          apiKey = toOpencodeEnvPath config.age.secrets.opencode-cf-ai-gw-api-key;
        };
        opencode-go.options.apiKey = toOpencodeEnvPath config.age.secrets.opencode-go-api-key;
      };
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

  systemd.user.services.opencode-web.Service.EnvironmentFile =
    toSystemdRuntimePath config.age.secrets.opencode-server-env;

  xdg.configFile."opencode/plugins/peon-ping.ts".source = pkgs.runCommand "peon-ping.ts" { } ''
    cp ${
      inputs.peon-ping.packages.${pkgs.stdenv.hostPlatform.system}.default
    }/share/peon-ping/adapters/opencode/peon-ping.ts $out

    sed -i '/const PEON_SH_PATHS = \[/a\  path.join(os.homedir(), ".openpeon", "peon.sh"),' $out
  '';

  programs.zsh.initContent = lib.mkAfter ''
    opencode() {
      if [[ $# -eq 0 ]]; then
        OPENCODE_SERVER_PASSWORD=$(cat ${config.age.secrets.opencode-server-password.path}) \
          command opencode attach http://localhost:9090
      else
        command opencode "$@"
      fi
    }
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

  age.secrets = {
    opencode-cf-ai-gw-api-key.rekeyFile = ./cf_ai_gw_api_key.age;
    opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;

    opencode-server-password.rekeyFile = ./opencode_server_password.age;

    opencode-server-env = {
      rekeyFile = ./opencode_server_env.age;
      generator = {
        dependencies = {
          inherit (config.age.secrets) opencode-server-password;
        };
        script = "env";
      };
    };
  };
}

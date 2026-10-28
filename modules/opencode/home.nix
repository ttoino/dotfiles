{
  config,
  inputs,
  pkgs,
  ...
}:
let
  peon-ping = inputs.peon-ping.packages.${pkgs.stdenv.hostPlatform.system}.default;

  peon-ping-opencode-plugin = pkgs.runCommand "peon-ping-opencode-plugin" { } ''
        mkdir -p $out/share/opencode/plugins/peon-ping
        cp -r ${peon-ping}/share/peon-ping/adapters/opencode/* $out/share/opencode/plugins/peon-ping/
        ln -s peon-ping.ts $out/share/opencode/plugins/peon-ping/index.ts

        sed -i '/^function setTabTitle/,/^}/c\
    function setTabTitle(title: string): void {\
      return\
    }' $out/share/opencode/plugins/peon-ping/peon-ping.ts
  '';

  toOpencodeEnvPath = secret: "{file:${builtins.replaceStrings [ "\${" ] [ "{env:" ] secret.path}}";
in
{
  imports = [ inputs.peon-ping.homeManagerModules.default ];

  programs.opencode = {
    enable = true;
    context = ./AGENTS.md;
    extraPackages = with pkgs; [ systemd ];

    settings = {
      mcp = {
        servers = {
          firefox = {
            type = "local";
            command = [
              "${pkgs.firefox-devtools-mcp}/bin/firefox-devtools-mcp"
              "--headless"
              "--viewport"
              "1280x720"
            ];
          };
          github = {
            type = "local";
            command = [
              "${pkgs.github-mcp-server}/bin/github-mcp-server"
              "stdio"
            ];
            environment.GITHUB_PERSONAL_ACCESS_TOKEN = toOpencodeEnvPath config.age.secrets.github-mcp-pat;
          };
          material = {
            type = "remote";
            url = "https://material.mcp.toino.pt/mcp";
            timeout.execution = 600000;
          };
          nix = {
            type = "local";
            command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
          };
        };
      };

      model = "opencode-go/kimi-k2.7-code";

      plugins = [
        "opencode-sleep-inhibitor"
        "${peon-ping-opencode-plugin}/share/opencode/plugins/peon-ping"
      ];

      providers = {
        cloudflare-ai-gateway.settings = {
          accountId = "e024e5a1e487a3d3a07815b431986107";
          gatewayId = "opencode";
          apiKey = toOpencodeEnvPath config.age.secrets.opencode-cf-ai-gw-api-key;
        };

        opencode-go.settings.apiKey = toOpencodeEnvPath config.age.secrets.opencode-go-api-key;
      };

      skills =
        let
          anthropic = pkgs.sources.anthropic-skills.src;
          cloudflare = pkgs.sources.cloudflare-skills.src;
        in
        [
          "${cloudflare}/skills/cloudflare"
          "${anthropic}/skills/frontend-design"
          "${anthropic}/skills/skill-creator"
          "${cloudflare}/skills/wrangler"
        ];
    };
  };

  systemd.user.services.opencode = {
    Unit = {
      Description = "OpenCode built-in service";
      After = [
        "network.target"
        "agenix.service"
      ];
    };
    Service = {
      Type = "simple";
      ExecStartPre = pkgs.writeShellScript "opencode-service-pre" ''
        password=$(cat "${config.age.secrets.opencode-server-password.path}")
        mkdir -p "${config.xdg.configHome}/opencode"
        ${pkgs.jq}/bin/jq -n \
          --arg password "$password" \
          --arg hostname "127.0.0.1" \
          --argjson port 49374 \
          '{hostname: $hostname, port: $port, password: $password}' \
          > "${config.xdg.configHome}/opencode/service.json"
        chmod 600 "${config.xdg.configHome}/opencode/service.json"
      '';
      ExecStart = "${config.programs.opencode.package}/bin/opencode serve --service";
      ExecStop = "${config.programs.opencode.package}/bin/opencode service stop";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

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
    github-mcp-pat.rekeyFile = ./github_mcp_pat.age;
    opencode-cf-ai-gw-api-key.rekeyFile = ./cf_ai_gw_api_key.age;
    opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
    opencode-server-password.rekeyFile = ./opencode_server_password.age;
  };
}

{
  config,
  pkgs,
  ...
}:
let
  toOpencodeEnvPath = secret: "{file:${builtins.replaceStrings [ "\${" ] [ "{env:" ] secret.path}}";
in
{
  programs.opencode = {
    enable = true;
    context = ./AGENTS.md;
    extraPackages = with pkgs; [ systemd ];

    cli.attention = {
      notifications = true;
      sound = true;
    };

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

      plugins = [ "opencode-sleep-inhibitor" ];

      providers = {
        cloudflare-ai-gateway.settings = {
          accountId = "e024e5a1e487a3d3a07815b431986107";
          gatewayId = "opencode";
          gatewayApiKey = toOpencodeEnvPath config.age.secrets.opencode-cf-ai-gw-api-key;
        };

        opencode-go.settings.apiKey = toOpencodeEnvPath config.age.secrets.opencode-go-api-key;
      };

      skills =
        let
          anthropic = pkgs.sources.anthropic-skills.src;
          cloudflare = pkgs.sources.cloudflare-skills.src;
          mattpocock = pkgs.sources.mattpocock-skills.src;
        in
        [
          "${cloudflare}/skills/cloudflare"
          "${cloudflare}/skills/cf-cli"
          "${cloudflare}/skills/wrangler"

          "${anthropic}/skills/frontend-design"
          "${anthropic}/skills/skill-creator"

          "${mattpocock}/skills/engineering/code-review"
          "${mattpocock}/skills/engineering/codebase-design"
          "${mattpocock}/skills/engineering/prototype"
          "${mattpocock}/skills/engineering/research"
          "${mattpocock}/skills/engineering/tdd"
          "${mattpocock}/skills/productivity/grilling"
          "${mattpocock}/skills/productivity/writing-for-agents"
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

  age.secrets = {
    github-mcp-pat.rekeyFile = ./github_mcp_pat.age;
    opencode-cf-ai-gw-api-key.rekeyFile = ./cf_ai_gw_api_key.age;
    opencode-go-api-key.rekeyFile = ./opencode_go_api_key.age;
    opencode-server-password.rekeyFile = ./opencode_server_password.age;
  };
}

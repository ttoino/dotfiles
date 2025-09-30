{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-vscode-server.homeModules.default ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      extensions = with (pkgs.forVSCodeVersion pkgs.vscodium.version).vscode-marketplace; [
        # Git
        eamodio.gitlens
        github.vscode-github-actions
        github.vscode-pull-request-github

        # Language Support
        adpyke.vscode-sql-formatter
        bbenoist.nix
        docker.docker
        foxundermoon.shell-format
        haskell.haskell
        james-yu.latex-workshop
        jnoortheen.nix-ide
        justusadam.language-haskell
        llvm-vs-code-extensions.vscode-clangd
        mads-hartmann.bash-ide-vscode
        myriad-dreamin.tinymist
        redhat.vscode-xml
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        timonwong.shellcheck
        typescript-to-lua.vscode-typescript-to-lua

        # Markdown
        bierner.markdown-checkbox
        bierner.markdown-emoji
        bierner.markdown-footnotes
        bierner.markdown-mermaid
        bierner.markdown-preview-github-styles
        bierner.markdown-yaml-preamble
        bpruitt-goddard.mermaid-markdown-syntax-highlighting
        davidanson.vscode-markdownlint
        yzhang.markdown-all-in-one

        # Python
        charliermarsh.ruff
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-python.vscode-python-envs
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow

        # Web
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        ecmel.vscode-html-css
        esbenp.prettier-vscode
        jock.svg
        matthewpi.caddyfile-support
        meganrogge.template-string-converter
        pranaygp.vscode-css-peek
        svelte.svelte-vscode
        tobermory.es6-string-html
        vitest.explorer
        yoavbls.pretty-ts-errors

        # Other
        github.copilot
        gruntfuggly.todo-tree
        kisstkondoros.vscode-gutter-preview
        mkhl.direnv
        ms-azuretools.vscode-containers
        ms-azuretools.vscode-docker
        ms-vsliveshare.vsliveshare
        ritwickdey.liveserver
        streetsidesoftware.code-spell-checker
        streetsidesoftware.code-spell-checker-portuguese
        vscodevim.vim
      ];

      keybindings = [ ];

      userSettings = {
        # Editor
        "cSpell.language" = "en,pt";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "editor.rulers" = [ 80 ];
        "editor.semanticHighlighting.enabled" = true;
        "files.autoSave" = "afterDelay";
        "vim.smartRelativeLine" = true;

        # Git
        "diffEditor.ignoreTrimWhitespace" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "github.gitProtocol" = "ssh";
        "githubPullRequests.pullBranch" = "never";
        "scm.defaultViewMode" = "tree";

        # Language Support
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "docker.extension.enableComposeLanguageServer" = true;
        "haskell.manageHLS" = "PATH";
        "latex-workshop.formatting.latex" = "${pkgs.tex-fmt}/bin/tex-fmt";
        "latex-workshop.view.pdf.viewer" = "tab";
        "markdownlint.config" = {
          "MD033" = false;
        };
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
            };
          };
        };
        "yaml.schemas" = {
          "https://raw.githubusercontent.com/docker/vscode-extension/6a88caada42b57090df7ce91ec2a6561b422afe1/misc/empty.json" =
            [
              "compose*y*ml"
              "docker-compose*y*ml"
            ];
        };
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "[shellscript]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[sql]" = {
          "editor.defaultFormatter" = "adpyke.vscode-sql-formatter";
        };
        "[svg]" = {
          "editor.defaultFormatter" = "jock.svg";
        };

        # Other
        "telemetry.telemetryLevel" = "crash";
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "liveServer.settings.donotShowInfoMsg" = true;
        "liveshare.allowGuestDebugControl" = true;
        "liveshare.allowGuestTaskControl" = true;
        "liveshare.languages.allowGuestCommandControl" = true;
        "liveshare.notebooks.allowGuestExecuteCells" = true;
        "terminal.integrated.enableMultiLinePasteWarning" = "never";

        # Prettier
        "prettier.prettierPath" = "${pkgs.nodePackages.prettier}";
        "prettier.tabWidth" = 4;
        "prettier.trailingComma" = "all";
        "[css][github-actions-workflow][html][javascript][json][jsonc][markdown][scss][svelte][tailwindcss][typescript][typescriptreact][vue][yaml]" =
          {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
        "[github-actions-workflow][yaml]" = {
          "prettier.tabWidth" = 2;
        };

        # Python
        "jupyter.askForKernelRestart" = false;
        "python.analysis.autoFormatStrings" = true;
        "python.analysis.diagnosticMode" = "workspace";
        "python.analysis.inlayHints.callArgumentNames" = "partial";
        "python.analysis.inlayHints.functionReturnTypes" = true;
        "python.analysis.inlayHints.pytestParameters" = true;
        "python.analysis.inlayHints.variableTypes" = true;
        "python.analysis.typeCheckingMode" = "standard";
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };

        # Web
        "emmet.excludeLanguages" = [ "markdown" ];
        "emmet.includeLanguages" = {
          "svelte" = "html";
        };
        "eslint.validate" = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "svelte"
        ];
        "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "javascript.inlayHints.parameterTypes.enabled" = true;
        "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "javascript.inlayHints.variableTypes.enabled" = true;
        "javascript.preferences.quoteStyle" = "double";
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "svelte.ask-to-enable-ts-plugin" = false;
        "svelte.enable-ts-plugin" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.parameterTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.inlayHints.variableTypes.enabled" = true;
        "typescript.preferences.quoteStyle" = "double";
        "typescript.updateImportsOnFileMove.enabled" = "always";
      };
    };
  };

  services.vscode-server.enable = true;
}

{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  mk = mode: key: action: desc: {
    inherit
      key
      action
      desc
      mode
      ;
    lua = true;
    silent = true;
  };
  n = mk "n";
  nx = mk [
    "n"
    "x"
  ];
  nt = mk [
    "n"
    "t"
  ];

  snacksModules = [
    "picker"
    "explorer"
    "notifier"
    "statuscolumn"
    "indent"
    "bigfile"
    "quickfile"
    "words"
    "scope"
    "scroll"
    "input"
    "dashboard"
    "image"
    "gitbrowse"
    "gh"
  ];
in
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;

      globals.mapleader = " ";

      extraPackages = with pkgs; [
        gh
        imagemagick
      ];

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      options = {
        termguicolors = true;
        signcolumn = "yes";
        splitbelow = true;
        splitright = true;
        updatetime = 250;
        mouse = "a";
      };

      luaConfigPost = ''
        vim.opt.colorcolumn = "80"

        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
      '';

      treesitter.enable = true;

      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
        lightbulb.enable = true;
        lspkind.enable = true;
        trouble.enable = true;
      };

      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts.signature.enabled = true;
      };

      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      git.gitsigns.enable = true;
      binds.whichKey.enable = true;
      comments.comment-nvim.enable = true;
      autopairs.nvim-autopairs.enable = true;
      ui.colorizer.enable = true;
      visuals = {
        nvim-cursorline.enable = true;
        nvim-web-devicons.enable = true;
      };
      notes.todo-comments.enable = true;

      spellcheck = {
        enable = true;
        languages = [
          "en"
          "pt"
        ];
      };

      utility.snacks-nvim = {
        enable = true;
        setupOpts = lib.genAttrs snacksModules (_: {
          enabled = true;
        });
      };

      keymaps = [
        (n "<leader><space>" "Snacks.picker.smart()" "Smart Find Files")
        (n "<leader>," "Snacks.picker.buffers()" "Buffers")
        (n "<leader>/" "Snacks.picker.grep()" "Grep")
        (n "<leader>:" "Snacks.picker.command_history()" "Command History")
        (n "<leader>e" "Snacks.explorer()" "File Explorer")
        (n "<leader>ff" "Snacks.picker.files()" "Find Files")
        (n "<leader>fg" "Snacks.picker.git_files()" "Find Git Files")
        (n "<leader>fr" "Snacks.picker.recent()" "Recent Files")
        (n "<leader>sg" "Snacks.picker.grep()" "Grep")
        (nx "<leader>sw" "Snacks.picker.grep_word()" "Grep word/selection")
        (n "<leader>sb" "Snacks.picker.lines()" "Buffer Lines")
        (n "<leader>ss" "Snacks.picker.lsp_symbols()" "LSP Symbols")
        (n "<leader>sS" "Snacks.picker.lsp_workspace_symbols()" "LSP Workspace Symbols")
        (n "<leader>gb" "Snacks.picker.git_branches()" "Git Branches")
        (n "<leader>gl" "Snacks.picker.git_log()" "Git Log")
        (n "<leader>gs" "Snacks.picker.git_status()" "Git Status")
        (n "<leader>gd" "Snacks.picker.git_diff()" "Git Diff (Hunks)")
        (n "<leader>gf" "Snacks.picker.git_log_file()" "Git Log File")
        (nx "<leader>gB" "Snacks.gitbrowse()" "Git Browse")
        (n "<leader>gi" "Snacks.picker.gh_issue()" "GitHub Issues (open)")
        (n "<leader>gp" "Snacks.picker.gh_pr()" "GitHub Pull Requests (open)")
        (nt "]]" "Snacks.words.jump(vim.v.count1)" "Next Reference")
        (nt "[[" "Snacks.words.jump(-vim.v.count1)" "Prev Reference")
      ];

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.format.type = [ "nixfmt" ];

        typescript = {
          enable = true;
          format.type = [ "prettierd" ];
          extensions.ts-error-translator.enable = true;
        };

        python = {
          enable = true;
          lsp.servers = [
            "basedpyright"
            "ruff"
          ];
          format.type = [ "ruff" ];
        };

        rust = {
          enable = true;
          extensions.crates-nvim.enable = true;
        };

        clang.enable = true;
        lua.enable = true;
        bash.enable = true;
        html.enable = true;
        css.enable = true;
        svelte.enable = true;
        docker.enable = true;
        yaml.enable = true;
        toml.enable = true;
        typst.enable = true;

        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
      };
    };
  };
}

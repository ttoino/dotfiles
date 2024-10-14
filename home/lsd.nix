{ lib, ... }:
let
  mkIcons = icons: (lib.lists.fold (a: b: a // b) { }
    (lib.lists.forEach icons
      (arg: lib.attrsets.genAttrs (builtins.elemAt arg 1) (_: (builtins.elemAt arg 0)))));
in
{
  programs.lsd = {
    enable = true;

    settings = {
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
        "git"
      ];

      icons.separator = "  ";

      sorting.dir-grouping = "first";

      total-size = true;
      hyperlink = "auto";
    };
  };

  xdg.configFile."lsd/icons.yaml".text = lib.generators.toYAML { } {
    filetype = {
      dir = "󰉋";
      file = "󰈔";
      pipe = "󰛮";
      socket = "󰅟";
      executable = "󰣖";
      symlink-dir = "󱧮";
      symlink-file = "󰪹";
      device-char = "󰐪";
      device-block = "󰗮";
      special = "󱀺";
    };

    # TODO
    name = mkIcons [
      [ "󰀲" [ ] ] # Android
      [ "󰀵" [ ] ] # Apple
      [ "󰛫" [ ] ] # Archive
      [ "󰝚" [ ] ] # Audio
      [ "󰁯" [ ] ] # Backup
      [ "󰂫" [ ] ] # Blender
      [ "󰂽" [ ] ] # Book
      [ "󰙱" [ ] ] # C
      [ "󰙲" [ ] ] # C++
      [ "󰌛" [ ] ] # C#
      [ "󰆍" [ ] ] # Console
      [ "󰒓" [ ] ] # Config
      [ "󰌜" [ ] ] # CSS
      [ "󰆼" [ ] ] # Database
      [ "󰦓" [ ] ] # Diff
      [ "󰗮" [ ] ] # Disc image
      [ "󰡨" [ ] ] # Docker
      [ "󰂺" [ ] ] # Docs
      [ "󰈙" [ ] ] # Document
      [ "󰇚" [ ] ] # Download
      [ "󰘮" [ ] ] # Environment
      [ "󰣖" [ ] ] # Executable
      [ "󰛖" [ ] ] # Font
      [ "󰊢" [ ] ] # Git
      [ "󰟓" [ ] ] # Go
      [ "󰟆" [ ] ] # Gradle
      [ "󰲒" [ ] ] # Haskell
      [ "󰋚" [ ] ] # History
      [ "󰌝" [ ] ] # HTML
      [ "󰋩" [ ] ] # Images
      [ "󰅶" [ ] ] # Java/Coffee
      [ "󰌞" [ ] ] # JavaScript
      [ "󰘦" [ ] ] # JSON/YAML/TOML
      [ "󱈙" [ ] ] # Kotlin
      [ "󰌾" [ ] ] # Lock
      [ "󰢱" [ ] ] # Lua
      [ "󰍇" [ ] ] # Magnet
      [ "󰍔" [ ] ] # Markdown
      [ "󰿉" [ ] ] # Math
      [ "󱄅" [ ] ] # Nix
      [ "󰏓" [ ] ] # Package/Library
      [ "󰌟" [ ] ] # PHP
      [ "󰌠" [ ] ] # Python
      [ "󰜈" [ ] ] # React
      [ "󰴭" [ ] ] # Ruby
      [ "󰫏" [ ] ] # Ruby on rails
      [ "󱘗" [ ] ] # Rust
      [ "󰟬" [ ] ] # Sass
      [ "󰐨" [ ] ] # Slides
      [ "󰓫" [ ] ] # Spreadsheet
      [ "󰅞" [ ] ] # Subtitles
      [ "󰛥" [ ] ] # Swift
      [ "󰈚" [ ] ] # Text
      [ "󰛦" [ ] ] # TypeScript
      [ "󰚯" [ ] ] # Unity
      [ "󰜡" [ ] ] # Vector images
      [ "󰎁" [ ] ] # Video
      [ "󰨞" [ ] ] # VSCode
      [ "󰡄" [ ] ] # Vue
      [ "󰗀" [ ] ] # XML

      [
        "󰋖"
        [
          "a.out"
          "api"
          ".asoundrc"
          ".atom"
          ".ash"
          ".ash_history"
          "authorized_keys"
          "assets"
          ".android"
          ".audacity-data"
          "backups"
          ".bash_history"
          ".bash_logout"
          ".bash_profile"
          ".bashrc"
          "bin"
          ".bpython_history"
          "build"
          "bspwmrc"
          "build.ninja"
          ".cache"
          "cache"
          "cargo.lock"
          "cargo.toml"
          ".cargo"
          ".ccls-cache"
          "changelog"
          ".clang-format"
          "composer.json"
          "composer.lock"
          "conf.d"
          "config.ac"
          "config.el"
          "config.mk"
          ".config"
          "config"
          "configure"
          "content"
          "contributing"
          "copyright"
          "cron.daily"
          "cron.d"
          "cron.deny"
          "cron.hourly"
          "cron.monthly"
          "crontab"
          "cron.weekly"
          "crypttab"
          ".cshrc"
          "csh.cshrc"
          "csh.login"
          "csh.logout"
          "css"
          "custom.el"
          ".dbus"
          "desktop"
          "docker-compose.yml"
          "dockerfile"
          "doc"
          "dist"
          "documents"
          ".doom.d"
          "downloads"
          ".ds_store"
          ".editorconfig"
          ".electron-gyp"
          ".emacs.d"
          ".env"
          "environment"
          ".eslintrc.json"
          ".eslintrc.js"
          ".eslintrc.yml"
          "etc"
          "favicon.ico"
          "favicons"
          ".fennelrc"
          "fstab"
          ".fastboot"
          ".gitattributes"
          ".gitconfig"
          ".git-credentials"
          ".github"
          "gitignore_global"
          ".gitignore"
          ".gitlab-ci.yml"
          ".gitmodules"
          ".git"
          ".gnupg"
          "go.mod"
          "go.sum"
          "go.work"
          "gradle"
          "gradle.properties"
          "gradlew"
          "gradlew.bat"
          "group"
          "gruntfile.coffee"
          "gruntfile.js"
          "gruntfile.ls"
          "gshadow"
          "gulpfile.coffee"
          "gulpfile.js"
          "gulpfile.ls"
          "heroku.yml"
          "hidden"
          "home"
          "hostname"
          "hosts"
          ".htaccess"
          "htoprc"
          ".htpasswd"
          ".icons"
          "icons"
          "id_dsa"
          "id_ecdsa"
          "id_rsa"
          ".idlerc"
          "img"
          "include"
          "init.el"
          ".inputrc"
          "inputrc"
          ".java"
          "jenkinsfile"
          "js"
          ".jupyter"
          "kbuild"
          "kconfig"
          "kdeglobals"
          "kdenliverc"
          "known_hosts"
          ".kshrc"
          "libexec"
          "lib32"
          "lib64"
          "lib"
          "license.md"
          "licenses"
          "license.txt"
          "license"
          "localized"
          "lsb-release"
          ".lynxrc"
          ".mailcap"
          "mail"
          "magic"
          "maintainers"
          "makefile.ac"
          "makefile"
          "manifest"
          "md5sum"
          "meson.build"
          "metadata"
          "metadata.xml"
          "media"
          ".mime.types"
          "mime.types"
          "module.symvers"
          ".mozilla"
          "music"
          "muttrc"
          ".muttrc"
          ".mutt"
          ".mypy_cache"
          "neomuttrc"
          ".neomuttrc"
          "netlify.toml"
          ".nix-channels"
          ".nix-defexpr"
          ".node-gyp"
          "node_modules"
          ".node_repl_history"
          "npmignore"
          ".npm"
          "nvim"
          "obj"
          "os-release"
          "package.json"
          "package-lock.json"
          "packages.el"
          "pam.d"
          "passwd"
          "pictures"
          "pkgbuild"
          ".pki"
          "portage"
          "profile"
          ".profile"
          "public"
          "__pycache__"
          "pyproject.toml"
          ".python_history"
          ".pypirc"
          "rc.lua"
          "readme"
          ".release.toml"
          "requirements.txt"
          "robots.txt"
          "root"
          "rubydoc"
          "runtime.txt"
          ".rustup"
          "rustfmt.toml"
          ".rvm"
          "sass"
          "sbin"
          "scripts"
          "scss"
          "sha256sum"
          "shadow"
          "share"
          ".shellcheckrc"
          "shells"
          ".spacemacs"
          ".sqlite_history"
          "src"
          ".ssh"
          "static"
          "std"
          "styles"
          "subgid"
          "subuid"
          "sudoers"
          "sxhkdrc"
          "template"
          "tests"
          "tigrc"
          "timezone"
          "tox.ini"
          ".trash"
          "ts"
          ".tox"
          "unlicense"
          "url"
          "user-dirs.dirs"
          "vagrantfile"
          "vendor"
          "venv"
          "videos"
          ".viminfo"
          ".vimrc"
          "vimrc"
          ".vim"
          "vim"
          ".vscode"
          "webpack.config.js"
          ".wgetrc"
          "wgetrc"
          ".xauthority"
          ".Xauthority"
          "xbps.d"
          "xbps-src"
          ".xinitrc"
          ".xmodmap"
          ".Xmodmap"
          "xmonad.hs"
          "xorg.conf.d"
          ".xprofile"
          ".Xprofile"
          ".xresources"
          ".yarnrc"
          "yarn.lock"
          "zathurarc"
          ".zcompdump"
          ".zlogin"
          ".zlogout"
          ".zprofile"
          ".zsh_history"
          ".zshrc"
        ]
      ] # Other
    ];

    # TODO
    extension = mkIcons [
      [ "󰀲" [ "apk" ] ] # Android
      [ "󰀵" [ "ds_store" ] ] # Apple
      [ "󰛫" [ "7z" "ar" "bz2" "gz" "lz" "rar" "tar" "taz" "tbz" "tbz2" "tgz" "xz" "zip" "zst" ] ] # Archive
      [ "󰝚" [ "ape" "cue" "flac" "m4a" "mp3" "ogg" "opus" "wav" "wma" ] ] # Audio
      [ "󰁯" [ "bak" "old" "orig" ] ] # Backup
      [ "󰂫" [ "blend" "blend1" ] ] # Blender
      [ "󰂽" [ "ebook" "epub" ] ] # Book
      [ "󰙱" [ "c" "h" ] ] # C
      [ "󰙲" [ "cc" "cpp" "cp" "c++" "cxx" "hh" "hpp" "hxx" ] ] # C++
      [ "󰌛" [ "csproj" "cs" "csx" ] ] # C#
      [ "󰆍" [ "awk" "bashrc" "bash" "bat" "csh" "fish" "ksh" "ps1" "shell" "sh" "zshrc" "zsh-theme" "zsh" ] ] # Console
      [ "󰒓" [ "bash_profile" "cfg" "conf" "editorconfig" "ini" ] ] # Config
      [ "󰌜" [ "css" ] ] # CSS
      [ "󰆼" [ "db" "sqlite3" "sql" ] ] # Database
      [ "󰦓" [ "diff" "patch" ] ] # Diff
      [ "󰗮" [ "iso" ] ] # Disc image
      [ "󰡨" [ "dockerfile" ] ] # Docker
      [ "󰂺" [ "1" "2" "3" "4" "5" "6" "7" "8" "man" ] ] # Docs
      [ "󰈙" [ "doc" "docx" "gdoc" "odt" "pdf" ] ] # Document
      [ "󰇚" [ "download" "part" ] ] # Download
      [ "󰘮" [ "env" ] ] # Environment
      [ "󰣖" [ "elf" "exe" "msi" ] ] # Executable
      [ "󰛖" [ "eot" "font" "otf" "ttc" "ttf" "woff2" "woff" ] ] # Font
      [ "󰊢" [ "git" ] ] # Git
      [ "󰟓" [ "go" ] ] # Go
      [ "󰟆" [ "gradle" ] ] # Gradle
      [ "󰲒" [ "hs" "lhs" ] ] # Haskell
      [ "󰋚" [ "bash_history" ] ] # History
      [ "󰌝" [ "html" "htm" ] ] # HTML
      [ "󰋩" [ "apng" "avif" "bmp" "gif" "heic" "heif" "heix" "ico" "image" "jpeg" "jpg" "png" "psd" "tiff" "webp" "xcf" ] ] # Images
      [ "󰅶" [ "class" "coffee" "jar" "java" ] ] # Java/Coffee
      [ "󰌞" [ "cjs" "js" "mjs" ] ] # JavaScript
      [ "󰘦" [ "avro" "jsonc" "json" "toml" "yaml" "yml" ] ] # JSON/YAML/TOML
      [ "󱈙" [ "kt" "kts" ] ] # Kotlin
      [ "󰌾" [ "lock" ] ] # Lock
      [ "󰢱" [ "lua" ] ] # Lua
      [ "󰍇" [ "magnet" ] ] # Magnet
      [ "󰍔" [ "markdown" "md" "mkd" ] ] # Markdown
      [ "󰿉" [ "tex" ] ] # Math
      [ "󱄅" [ "nix" ] ] # Nix
      [ "󰏓" [ "a" "deb" "dll" "pkg" "rpm" "so" ] ] # Package/Library
      [ "󰌟" [ "php" ] ] # PHP
      [ "󰌠" [ "egg-info" "ipynb" "pyc" "py" ] ] # Python
      [ "󰜈" [ "jsx" "tsx" ] ] # React
      [ "󰴭" [ "rb" ] ] # Ruby
      [ "󰫏" [ "erb" ] ] # Ruby on rails
      [ "󱘗" [ "rlib" "rmeta" ] ] # Rust
      [ "󰟬" [ "sass" "scss" ] ] # Sass
      [ "󰐨" [ "gslides" "odp" "ppt" "pptx" ] ] # Slides
      [ "󰓫" [ "csv" "gsheet" "ods" "tsv" "xls" "xlsx" ] ] # Spreadsheet
      [ "󰅞" [ "890" "cip" "sbv" "scc" "smi" "srt" "sub" "vtt" ] ] # Subtitles
      [ "󰛥" [ "swift" ] ] # Swift
      [ "󰈚" [ "log" "txt" ] ] # Text
      [ "󰛦" [ "cts" "mts" "ts" ] ] # TypeScript
      [ "󰚯" [ "unity" "unity32" ] ] # Unity
      [ "󰜡" [ "ai" "svg" ] ] # Vector images
      [ "󰎁" [ "avi" "flv" "m4v" "mkv" "mov" "mp4" "ogv" "video" "webm" "wmv" ] ] # Video
      [ "󰨞" [ ] ] # VSCode
      [ "󰡄" [ "vue" ] ] # Vue
      [ "󰗀" [ "asp" "ejs" "xml" ] ] # XML

      [
        "󰋖"
        [
          "asc"
          "asm"
          "bin"
          "bio"
          "cljs"
          "clj"
          "cls"
          "cl"
          "cshtml"
          "cypher"
          "dart"
          "dat"
          "desktop"
          "dump"
          "ebuild"
          "eclass"
          "elc"
          "elm"
          "el"
          "erl"
          "exs"
          "ex"
          "fnl"
          "fpl"
          "fsi"
          "fs"
          "fsx"
          "gemfile"
          "gemspec"
          "gform"
          "guardfile"
          "gv"
          "hbs"
          "img"
          "iml"
          "info"
          "in"
          "j2"
          "jinja"
          "jl"
          "key"
          "kusto"
          "ldb"
          "ld"
          "less"
          "license"
          "lisp"
          "list"
          "localized"
          "lss"
          "mgc"
          "m3u8"
          "m3u"
          "malloy"
          "mk"
          "ml"
          "mli"
          "mll"
          "mly"
          "mobi"
          "mustache"
          "nim"
          "nimble"
          "npmignore"
          "org"
          "o"
          "pdb"
          "pem"
          "phar"
          "pl"
          "plist"
          "pls"
          "plx"
          "pm"
          "pod"
          "pp"
          "procfile"
          "properties"
          "prql"
          "pub"
          "slt"
          "pxm"
          "rakefile"
          "razor"
          "rdata"
          "rdb"
          "rdoc"
          "rds"
          "readme"
          "rl"
          "rmd"
          "rproj"
          "rq"
          "rspec_parallel"
          "rspec_status"
          "rspec"
          "rss"
          "rs"
          "rtf"
          "rubydoc"
          "r"
          "ru"
          "scala"
          "scpt"
          "sig"
          "slim"
          "sln"
          "styl"
          "stylus"
          "sublime-menu"
          "sublime-package"
          "sublime-project"
          "sublime-session"
          "s"
          "svelte"
          "swp"
          "sym"
          "timestamp"
          "torrent"
          "trash"
          "t"
          "twig"
          "vim"
          "vlc"
          "whl"
          "windows"
          "wpl"
          "xbps"
          "xul"
          "zig"
          "zon"
        ]
      ] # Other
    ];
  };
}

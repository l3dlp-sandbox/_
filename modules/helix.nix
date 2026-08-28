{
  config,
  pkgs,
  lib,
  ...
}: let
  colorPreview = {
    name = "uwu-colors";
    only-features = ["document-colors"];
  };
  mkPrettier = parser: tabWidth: {
    command = "prettier";
    args = ["--parser" parser "--tab-width" (toString tabWidth)];
  };
  # published npm tarballs, flat node_modules; upstream's lockfile is
  # pnpm-shaped so buildNpmPackage can't install from it, and the blame-lsp
  # tarball ships prebuilt dist/ so no build step is needed
  blame-lsp = let
    npmTar = name: version: hash:
      pkgs.fetchurl {
        url = "https://registry.npmjs.org/${name}/-/${name}-${version}.tgz";
        inherit hash;
      };
    packages = {
      blame-lsp = npmTar "blame-lsp" "0.1.3" "sha256-jTNVStlZbnYDcLsyLQ11wyU/q02sYcuScniS3Tbpy7A=";
      vscode-jsonrpc = npmTar "vscode-jsonrpc" "8.2.0" "sha256-PaRFMcOY8VRQdMtyjjWagi81ufiscXHIR/QvByi5x8s=";
      vscode-languageserver = npmTar "vscode-languageserver" "9.0.1" "sha256-bNf0Y654cuWIpN1e1RSUdf4y5TUXUJqB5xXrBUBgJBI=";
      vscode-languageserver-protocol = npmTar "vscode-languageserver-protocol" "3.17.5" "sha256-dHPrLSFj8/i+oJZE+dgDeJoZXllrZdOUbEFX5YPjzMg=";
      vscode-languageserver-textdocument = npmTar "vscode-languageserver-textdocument" "1.0.12" "sha256-nx0ogU1u6BJn9S9byMkgu2oKI+tt5IlgNFoKJfvzsNs=";
      vscode-languageserver-types = npmTar "vscode-languageserver-types" "3.17.5" "sha256-1nP55/i75RNRvlHFjzLU3PqXpnDruGvGMzaDlMYJysA=";
    };
  in
    pkgs.runCommand "blame-lsp-0.1.3" {nativeBuildInputs = [pkgs.makeBinaryWrapper];} ''
      ${lib.concatStrings (lib.mapAttrsToList (name: src: ''
        mkdir -p $out/lib/node_modules/${name}
        tar xzf ${src} --strip-components=1 -C $out/lib/node_modules/${name}
      '')
      packages)}
      makeWrapper ${lib.getExe pkgs.nodejs} $out/bin/blame-lsp \
        --add-flags $out/lib/node_modules/blame-lsp/dist/server.js
    '';
in {
  programs.helix = {
    enable = true;
    extraPackages = [blame-lsp];
    settings = {
      editor = {
        gutters = [
          "diff"
          "line-numbers"
          "spacer"
          "diagnostics"
        ];
        cursorline = true;
        cursor-shape.insert = "bar";
        color-modes = true;
        true-color = true;
        file-picker = {
          max-depth = 8;
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            select = "SELECT";
            insert = "INSERT";
          };
          left = ["mode" "file-name"];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
            "version-control"
            "spacer"
          ];
        };
      };
      theme = "github_dark";
      keys = let
        esc = ["collapse_selection" "normal_mode"];
      in {
        normal = {
          inherit esc;
          X = "extend_line_above";
          V = ["extend_line_below" "select_mode"];
          G = "goto_file_end";
          g.q = ":reflow";
          C-b = ":sh git log -n 5 --format='format:%%h (%%an, %%ar) %%s' --no-patch -L%{cursor_line},+1:%{buffer_name}";
          C-r = ":reload";
          space = {
            w = ":write";
            q = ":quit";
            l.f = ":format";
            l.r = ":lsp-restart";
            l.g = ":sh gh browse";
            o = ":sh open build/$(sed 's/\\.typ$/.pdf/' <<< %{buffer_name})";
          };
        };
        insert = {
          inherit esc;
          C-n = "completion";
        };
        select = {
          inherit esc;
          A-s = ":pipe sort";
          space.g.c = ":sh gh browse -n %{buffer_name}:%{selection_line_start}-%{selection_line_end} | pbcopy";
          space.g.o = ":sh gh browse %{buffer_name}:%{selection_line_start}-%{selection_line_end}";
        };
      };
    };

    languages.language-server = {
      vhs-language-server = {
        command = "vhs";
        args = ["lsp"];
      };
      cook-lsp = {
        command = "cook";
        args = ["lsp"];
      };
      blame-lsp = {
        command = "blame-lsp";
        args = ["--stdio"];
      };
      uwu-colors = {
        command = "uwu_colors";
      };
      tinymist.config = {
        exportPdf = "onSave";
        fontPaths = ["${config.home.path}/share/fonts"];
        outputPath = "$root/$dir/build/$name";
        systemFonts = false;
      };
    };

    languages.grammar = [
      {
        name = "fennel";
        source.git = "https://github.com/TravonteD/tree-sitter-fennel";
        source.rev = "517195970428aacca60891b050aa53eabf4ba78d";
      }
      {
        name = "cooklang";
        source.git = "https://github.com/cooklang/tree-sitter-cooklang";
        source.rev = "dcc971c1d70cbcbf45bc54111d02a4294c91d9a2";
      }
    ];

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
        language-servers = ["nil" "nixd" colorPreview "blame-lsp"];
      }
      {
        name = "markdown";
        language-servers = ["marksman" "blame-lsp"];
      }
      {
        name = "go";
        formatter = {command = "goimports";};
        language-servers = ["gopls" "golangci-lint-lsp" "blame-lsp"];
      }
      {
        name = "lua";
        auto-format = true;
        language-servers = ["lua-language-server" "blame-lsp"];
      }
      {
        name = "rust";
        language-servers = ["rust-analyzer" "blame-lsp"];
      }
      {
        name = "vhs";
        auto-format = true;
        language-servers = ["vhs-language-server"];
      }
      {
        name = "html";
        auto-format = false;
        formatter = mkPrettier "html" 2;
      }
      {
        name = "css";
        formatter = mkPrettier "css" 2;
      }
      {
        name = "typescript";
        indent.tab-width = 4;
        indent.unit = "    ";
        formatter = mkPrettier "typescript" 4;
        language-servers = ["typescript-language-server" "blame-lsp"];
      }
      {
        name = "fennel";
        auto-format = true;
        comment-token = ";;";
        file-types = ["fnl"];
        injection-regex = "(fennel|fnl)";
        roots = [".git"];
        scope = "source.fnl";
      }
      {
        name = "cooklang";
        auto-format = true;
        comment-token = "--";
        file-types = ["cook"];
        grammar = "cooklang";
        injection-regex = "(cooklang|cook)";
        language-servers = ["cook-lsp"];
        roots = [];
        scope = "source.cook";
      }
      {
        name = "svg";
        scope = "";
        roots = [];
        file-types = ["svg"];
        formatter.command = "svgo";
        formatter.args = ["--pretty" "-"];
      }
      {
        name = "devicetree";
        file-types = ["dts" "dtsi" "keymap"];
      }
      {
        name = "toml";
        file-types = ["toml" "conf"];
      }
      {
        name = "typst";
        file-types = ["typ"];
        roots = [".git"];
        language-servers = ["tinymist" "blame-lsp"];
      }
    ];
  };
}

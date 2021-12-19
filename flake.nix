{
  description = "home";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
    copilot = { url = "github:github/copilot.vim"; flake = false; };
    gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    hop-nvim = { url = "github:phaazon/hop.nvim"; flake = false; };
    nordic-nvim = { url = "github:andersevenrud/nordic.nvim"; flake = false; };
    null-ls = { url = "github:jose-elias-alvarez/null-ls.nvim"; flake = false; };
    nvim-autopairs = { url = "github:windwp/nvim-autopairs"; flake = false; };
    nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    nvim-colorizer = { url = "github:norcalli/nvim-colorizer.lua"; flake = false; };
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    nvim-treesitter = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    popup-nvim = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    vim-rhubarb = { url = "github:tpope/vim-rhubarb"; flake = false; };
    vim-surround = { url = "github:tpope/vim-surround"; flake = false; };
    which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

    fnl = { url = "path:fnl"; flake = false; };
    hammerspoon = {
      url = "https://github.com/Hammerspoon/hammerspoon/releases/download/0.9.93/Hammerspoon-0.9.93.zip";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = rec {
      overlays = [
        (
          self: super: with self.vimUtils; let
            plug = name: buildVimPluginFrom2Nix { pname = name; src = inputs.${name}; version = "unstable"; };
          in
          {
            cmp-buffer = plug "cmp-buffer";
            cmp-nvim-lsp = plug "cmp-nvim-lsp";
            cmp-path = plug "cmp-path";
            copilot = plug "copilot";
            gitsigns-nvim = plug "gitsigns-nvim";
            hop-nvim = plug "hop-nvim";
            nordic-nvim = plug "nordic-nvim";
            null-ls = plug "null-ls";
            nvim-autopairs = plug "nvim-autopairs";
            nvim-cmp = plug "nvim-cmp";
            nvim-colorizer = plug "nvim-colorizer";
            nvim-lspconfig = plug "nvim-lspconfig";
            nvim-treesitter = plug "nvim-treesitter";
            plenary-nvim = plug "plenary-nvim";
            popup-nvim = plug "popup-nvim";
            telescope-nvim = plug "telescope-nvim";
            vim-rhubarb = plug "vim-rhubarb";
            vim-surround = plug "vim-surround";
            which-key-nvim = plug "which-key-nvim";

            hammerspoon = self.pkgs.stdenv.mkDerivation {
              pname = "hammerspoon";
              version = "0.9.93";
              src = inputs.hammerspoon;
              buildInputs = [ self.pkgs.fennel ];
              installPhase = ''
                mkdir -p $out/Applications/Hammerspoon.app
                cp -r $src/Contents $out/Applications/Hammerspoon.app/
                ln -sf $out/Applications/Hammerspoon.app/ /Applications/
              '';
            };

            fnl = self.pkgs.stdenv.mkDerivation {
              pname = "fnl";
              version = "unstable";
              src = inputs.fnl;
              buildInputs = [ self.pkgs.fennel ];
              installPhase = ''
                mkdir -p $out
                fennel --compile $src/init.fnl > $out/init.lua
                fennel --compile $src/hammerspoon.fnl > $out/hammerspoon.lua
              '';
            };
          }
        )
        inputs.neovim-nightly-overlay.overlay
      ];
      spin = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/spin";
        username = "spin";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-linux; })
          ];
          imports = [
            ./modules/fzf.nix
            ./modules/packages.nix
            ./modules/shell.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
      home = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-darwin";
        homeDirectory = "/Users/maas";
        username = "maas";
        configuration = { pkgs, ... }: {
          nixpkgs.overlays = overlays ++ [
            (self: super: { unstable = inputs.nixpkgs.legacyPackages.x86_64-darwin; })
          ];
          imports = [
            ./modules/alacritty.nix
            ./modules/fonts.nix
            ./modules/fzf.nix
            ./modules/gh.nix
            ./modules/git.nix
            ./modules/hammerspoon.nix
            ./modules/kitty.nix
            ./modules/packages.nix
            ./modules/scim.nix
            ./modules/shell.nix
            ./modules/spotify.nix
            ./modules/tmux.nix
            ./modules/vim.nix
          ];
        };
      };
    };
    home = self.homeConfigurations.home.activationPackage;
    spin = self.homeConfigurations.spin.activationPackage;
  };
}

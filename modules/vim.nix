{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua <<EOF
      ${builtins.readFile ../lua/init.lua}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        conjure
        hop-nvim
        nvim-autopairs
        nvim-lspconfig
        popup-nvim
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        gitsigns-nvim
        neorg
        nordbuddy-nvim
        nvim-compe
        nvim-treesitter
        plenary-nvim
        telescope-nvim
        which-key-nvim
      ]
    );
  };
}

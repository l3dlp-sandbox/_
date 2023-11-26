{pkgs, ...}: let
  core = with pkgs;
    [
      entr
      eza
      fd
      git
      gnupg
      jq
      pastel
      ripgrep
      sd
    ]
    ++ (import ./lsp.nix {pkgs = pkgs;});

  darwin = with pkgs; [
    age
    alejandra
    awscli2
    bore-cli
    btop
    bundix
    cachix
    chafa
    circumflex
    coreutils
    cowsay
    delve
    deno
    fennel
    ffmpeg_5
    fzf
    git-lfs
    go-swagger
    go_1_21
    gopass
    hammerspoon
    htop
    imagemagick
    libwebp
    llvm
    lolcat
    lsix
    monitorcontrol
    nodejs
    nushell
    openssl
    optipng
    pandoc
    postgresql
    python311Packages.grip
    redis
    rm-improved
    rustup
    sc-im
    simple-http-server
    spotify-tui
    spotifyd
    twurl
    yarn
    yq
    zig
  ];

  linux = with pkgs; [
    gcc
    dunst
    waybar

    go_1_21
    brave
  ];

  charmbracelet = with pkgs; [
    # gum
    # vhs
    charm
    melt
    pop
    skate
    soft-serve
  ];
in {
  home.packages =
    core
    ++ charmbracelet
    ++ (
      if pkgs.stdenv.isDarwin
      then darwin
      else linux
    );

  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;
}

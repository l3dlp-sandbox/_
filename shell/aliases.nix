rec {
  "..." = "cd ../..";
  "...." = "cd ../../..";
  "....." = "cd ../../../..";
  _ = "cd ~/_";

  dstroy = "fd -H .DS_Store | xargs sudo rm";

  g = "git";
  ga = "git add";
  gb = "git branch";
  gbc = "${gb} --show-current";
  gc = "git commit";
  gcam = "${gc} -am";
  gcm = "${gc} -m";
  gca = "${gc} --amend";
  gco = "git checkout";
  gcom = "${gco} master";
  gcp = "git cherry-pick";
  gcpa = "${gcp} --abort";
  gd = "git diff";
  gdm = "${gd} master";
  gl = "git pull";
  glo = "git log";
  gm = "git merge";
  gma = "${gm} --abort";
  gp = "git push";
  gpf = "${gp} --force-with-lease";
  gpsup = "${gp} --set-upstream origin `${gbc}`";
  gpos = "${gp} origin +@:staging";
  grb = "git rebase";
  grba = "${grb} --abort";
  grbc = "${grb} --continue";
  grbi = "${grb} --interactive";
  grbm = "${grb} master";
  gr = "git reset";
  grh = "${gr} --hard";
  grs = "git restore";
  gs = "${gss} --short";
  gss = "git status";
  gst = "git stash";
  gstp = "${gst} pop";
  gsw = "git switch";
  gswm = "${gsw} master";

  hms = "home-manager switch";

  ls = "exa";
  lsa = "exa -Fla";

  md = "mkdir";

  sz = "source ~/.config/zsh/.zshrc";

  ncg = "nix-collect-garbage";

  ta = "tmux attach -t";
  tkss = "tmux kill-session -t";
  tksv = "tmux kill-server";
  tls = "tmux list-sessions";
  tn = "tmux new-session -s";
  tns = "tmux new-session -A -s `basename $(pwd)`";

  vi = "nvim";
  v = "${vi} .";
  vim = "${vi}";


  scratch = "FILE=`mktemp /tmp/scratch.XXXXXX`; vim $FILE +startinsert && pbcopy < $FILE; rm $FILE";

  weather = "curl http://v2.wttr.in";
  wiki = "cd ~/wiki && vim ~/wiki/index.wiki";
}

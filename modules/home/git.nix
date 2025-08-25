{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      acp = "!f() { git add -A && git commit -m \"$1\" && git push; }; f";
      prune-gone = "!git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      cane = "commit --amend --no-edit";
      pfwl = "push --force-with-lease";
      as = "!f() { git add -A && git status; }; f";
      ds = "diff --staged";
      ad = "!f() { git add -A && git diff --staged; }; f";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nixCats";
        autocrlf = "input";
      };
      user = {
        email = "parkerbedlan@gmail.com";
        name = "Parker Bedlan";
      };
      push.autoSetupRemote = true;
    };
    # https://mynixos.com/home-manager/option/programs.git.delta.enable
    # https://github.com/dandavison/delta
    # delta.enable = true;
  };
}

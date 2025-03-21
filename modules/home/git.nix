{ ... }:
{
  programs.git = {
    enable = true;
    aliases = {
      acp = "!f() { git add -A && git commit -m \"$1\" && git push; }; f";
      prune-gone = "!git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d";
      cane = "commit --amend --no-edit";
      as = "!f() { git add -A && git status; }; f";
      pfwl = "push --force-with-lease";
      ds = "diff --staged";
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
  };
}

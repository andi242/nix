# { system, ... }: 
{
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
    buffers.bindToCwd = false;
    buffers.followCurrentFile.enabled = true;
    buffers.followCurrentFile.leaveDirsOpen = true;
    filesystem = {
      useLibuvFileWatcher = true;
      hijackNetrwBehavior = "open_default";
      filteredItems = {
        hideDotfiles = false;
        hideGitignored = false;
        hideHidden = false;
      };
    };
    addBlankLineAtTop = false;
  };
}

# {config, pkgs, system, ...}: 
{
  plugins.snacks = {
    enable = true;
    settings = {
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      statuscolumn = {
          enabled = true;
      };
      indent = {
        enabled = true;
        char = "│";
        only_scope = false;
        only_current = false;
      };
      dashboard = {
        enabled = false;
        luaConfig = ''
          sections = {
            { section = 'header', padding = 1 },
            { section = 'keys', padding = 2 },
            { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 3, padding = 2 },
            { section = 'projects', icon = ' ', title = 'Projects', indent = 3, padding = 2 },
            {
              section = 'terminal',
              icon = ' ',
              title = 'Git Status',
              enabled = vim.fn.isdirectory('.git') == 1,
              cmd = 'git diff --stat -B -M -C',
              height = 8,
              padding = 2,
              indent = 0
            },
            { section = 'startup' }
          }
        '';
      };
    };
  };
}

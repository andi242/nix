# {config, pkgs, system, ...}: 
{

  plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 50;
        search_method = "cover_or_next";
      };
      comment = {
        mappings = {
          comment = "gcc";
          comment_line = "gcc";
          comment_visual = "gc";
          textobject = "gcc";
        };
      };
      pairs = {};
      icons = {};
      trailspace = {};
      sessions = {
        enable = true;
      };
      # surround = {
      #   mappings = {
      #     add = "gsa";
      #     delete = "gsd";
      #     find = "gsf";
      #     find_left = "gsF";
      #     highlight = "gsh";
      #     replace = "gsr";
      #     update_n_lines = "gsn";
      #   };
      # };
    };
  };
}

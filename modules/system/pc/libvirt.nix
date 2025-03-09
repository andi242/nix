{
  virtualisation.libvirtd.enable = true;
  programs = {
    virt-manager.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

  };
}

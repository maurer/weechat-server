{ pkgs, ... }:

{
    require = [ "/home/maurer/Development/PersonalServices/irc/weechat.nix" ];

    users.extraUsers.root.openssh.authorizedKeys.keys = [ (builtins.readFile ../id_rsa.pub) ];
    users.extraUsers.maurer.openssh.authorizedKeys.keys = [ (builtins.readFile ../id_rsa.pub) ];
    users.extraUsers.maurer.isNormalUser = true;
    networking.firewall.enable = false;

    services.openssh.enable = true;
    services.weechat.enable = true;

    environment.systemPackages = with pkgs; [
      tmux
      rxvt_unicode.terminfo
      openssl
    ];

    networking.hostName = "weechat";
}

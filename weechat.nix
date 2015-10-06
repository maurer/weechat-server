{ config, lib, pkgs, ... }:

{
  options = {
    services.weechat = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          If enabled, a per-user weechat instance will be spawned on boot.
        '';
      };
    };
  };

  config = {
    systemd.user.services.weechat = {
      description = "WeeChat IRC Relay";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart="${pkgs.tmux}/bin/tmux -2 new-session -d -s irc ${pkgs.weechat}/bin/weechat";
        ExecStop ="${pkgs.tmux}/bin/tmux kill-session -t irc";
      };
    };
  };
}

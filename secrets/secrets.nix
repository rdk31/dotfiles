let
  xps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEToRaoJ6Zwyt+dluNPfOKFVLq2UXMo/9l0ez0u5D7Wb";

  hosts = [ xps ];

  rdk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXNDv/ryVeTXXt6I14RPbshybrgJgWbnhhIj3Om2mJO rdk@xps";

  users = [ rdk ];
in
{
  "ssh-config.age".publicKeys = users ++ [ xps ];
  "newsboat-urls.age".publicKeys = users ++ [ xps ];
}

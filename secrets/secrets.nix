let
  xps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEToRaoJ6Zwyt+dluNPfOKFVLq2UXMo/9l0ez0u5D7Wb";

  rdk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXNDv/ryVeTXXt6I14RPbshybrgJgWbnhhIj3Om2mJO rdk@xps";
in
{
  "ssh-config.age".publicKeys = [ rdk xps ];
  "newsboat-urls.age".publicKeys = [ rdk xps ];
}

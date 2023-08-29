final: prev: {
  ilspy = prev.callPackage ./ilspy.nix { };
  relion = prev.callPackage ./relion.nix { };
}

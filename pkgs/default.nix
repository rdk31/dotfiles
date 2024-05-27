final: prev: {
  ilspy = prev.callPackage ./ilspy.nix { };
  relion = prev.callPackage ./relion.nix { };
  lychee-slicer = prev.callPackage ./lychee-slicer.nix { };
}

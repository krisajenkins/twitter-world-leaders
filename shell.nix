with (import <nixpkgs> {}).haskellPackages;
let lens_4_4 = callPackage ./lens-4_4_0_2.nix {};
in
callPackage ./. {
  lens = lens_4_4;
  twitterConduit = callPackage ./twitter-conduit.nix {
	lens = lens_4_4;
    twitterTypesLens = callPackage ./twitter-types-lens.nix {
		lens = lens_4_4;
	};
    lensAeson = callPackage ./lens-aeson.nix {
		lens = lens_4_4;
	};
  };
}

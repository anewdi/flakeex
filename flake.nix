{
    description = "flakesss";

    outputs = inputs:
    let
        settings = {
            hostname = "thinkpad"; #Select host
            system =  "x86_64-linux"; #Only matters for standalone
        };
    in
    {
        nixosConfigurations = {
            ${settings.hostname} = inputs.nixpkgs.lib.nixosSystem {
                modules = [
                    ./default.nix
                ];
                specialArgs = {
                    inherit settings;
                    inherit inputs; 
                };
            };
        };

        homeConfigurations.David = inputs.hm.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${settings.system};
            modules = [
                ./clients/home-manager/home.nix
            ];
            extraSpecialArgs = {
                inherit inputs;
            };
        };
    };

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "nixpkgs/nixos-24.05";

        hm = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ags = {
            url = "github:Aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sboot = { 
            url = "github:nix-community/lanzaboote/v0.4.1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.darwin.follows = "";
        };
        wallz = {
            url = "github:anewdi/wallz";
            flake = false;
        };
    };
}

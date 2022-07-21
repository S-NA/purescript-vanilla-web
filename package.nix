{ ps-pkgs, ... }:
  with ps-pkgs;
  { version = "0.0.1";
    dependencies =
      [ prelude
        effect
        functions
        maybe
        partial
      ];
  }
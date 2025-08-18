{ lib }:
with lib; {
  get_all_subdirs = rootPath:
    let
      readset = builtins.readDir rootPath;
      dirset = filterAttrs (_: type: type == "directory") readset;
      dirs = map (path.append rootPath) (builtins.attrNames dirset);
    in dirs;
    
    get_all_nix_files = rootPath:
      let
        readset = builtins.readDir rootPath;
        is_nix_file = strings.hasSuffix ".nix";
        fileset =
          filterAttrs (filename: type: (isNixFile filename) && type == "regular")
          readset;
        files = map (path.append rootPath) (builtins.attrNames fileset);
      in files;

  exists_or = a: b: if a == null then b else a;
}

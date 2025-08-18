{ local_lib, ... }:

{
  imports = local_lib.get_all_subdirs ./.;
}

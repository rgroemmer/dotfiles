{lib, ...}: {
  options.roles = {
    work = lib.mkEnableOption "work";
  };
}

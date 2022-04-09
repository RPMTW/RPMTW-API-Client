enum CurseForgeModLoaderType { any, forge, cauldron, liteLoader, fabric }

extension ModLoaderTypeExtension on CurseForgeModLoaderType {
  int get value {
    switch (this) {
      case CurseForgeModLoaderType.any:
        return 0;
      case CurseForgeModLoaderType.forge:
        return 1;
      case CurseForgeModLoaderType.cauldron:
        return 2;
      case CurseForgeModLoaderType.liteLoader:
        return 3;
      case CurseForgeModLoaderType.fabric:
        return 4;
    }
  }
}

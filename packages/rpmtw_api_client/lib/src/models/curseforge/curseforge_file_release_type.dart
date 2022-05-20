enum CurseForgeFileReleaseType {
  release,
  beta,
  alpha,
}

extension CurseForgeFileReleaseTypeExtension on CurseForgeFileReleaseType {
  int get value {
    switch (this) {
      case CurseForgeFileReleaseType.release:
        return 1;
      case CurseForgeFileReleaseType.beta:
        return 2;
      case CurseForgeFileReleaseType.alpha:
        return 3;
    }
  }
}

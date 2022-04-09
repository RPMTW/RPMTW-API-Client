enum CurseForgeModsSearchSort {
  featured,
  popularity,
  lastUpdated,
  name,
  author,
  totalDownloads,
  category,
  gameVersion
}

extension ModsSearchSortExtension on CurseForgeModsSearchSort {
  int get value {
    switch (this) {
      case CurseForgeModsSearchSort.featured:
        return 1;
      case CurseForgeModsSearchSort.popularity:
        return 2;
      case CurseForgeModsSearchSort.lastUpdated:
        return 3;
      case CurseForgeModsSearchSort.name:
        return 4;
      case CurseForgeModsSearchSort.author:
        return 5;
      case CurseForgeModsSearchSort.totalDownloads:
        return 6;
      case CurseForgeModsSearchSort.category:
        return 7;
      case CurseForgeModsSearchSort.gameVersion:
        return 8;
    }
  }
}

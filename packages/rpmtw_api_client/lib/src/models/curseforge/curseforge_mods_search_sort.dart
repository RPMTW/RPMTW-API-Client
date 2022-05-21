enum CurseForgeSortField {
  featured,
  popularity,
  lastUpdated,
  name,
  author,
  totalDownloads,
  category,
  gameVersion
}

extension ModsSearchSortExtension on CurseForgeSortField {
  int get value {
    switch (this) {
      case CurseForgeSortField.featured:
        return 1;
      case CurseForgeSortField.popularity:
        return 2;
      case CurseForgeSortField.lastUpdated:
        return 3;
      case CurseForgeSortField.name:
        return 4;
      case CurseForgeSortField.author:
        return 5;
      case CurseForgeSortField.totalDownloads:
        return 6;
      case CurseForgeSortField.category:
        return 7;
      case CurseForgeSortField.gameVersion:
        return 8;
    }
  }
}

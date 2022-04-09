enum CurseForgeGames {
  demeo,
  wildStar,

  /// Chronicles of Arcadia
  chroniclesOfArcadia,
  minecraft,

  /// Sid Meier's Civilization VI
  civ6,

  /// The Secret World
  tsw,

  /// Runes of Magic
  rom,

  /// Secret World Legends
  swlegends,

  /// The Elder Scrolls Online
  teso,
  darkestDungeon,
  amongUs,

  /// Kerbal Space Program
  kerbal,
  terraria,
  worldoftanks,
  stardewvalley,
  minecraftDungeons,

  /// StarCraft II
  sc2,

  /// World of Warcraft
  wow,
  survivingMars,
  rift
}

extension CurseForgeGamesExtension on CurseForgeGames {
  int get id {
    switch (this) {
      case CurseForgeGames.demeo:
        return 78135;
      case CurseForgeGames.wildStar:
        return 454;
      case CurseForgeGames.chroniclesOfArcadia:
        return 70667;
      case CurseForgeGames.minecraft:
        return 432;
      case CurseForgeGames.civ6:
        return 727;
      case CurseForgeGames.tsw:
        return 64;
      case CurseForgeGames.rom:
        return 335;
      case CurseForgeGames.swlegends:
        return 4455;
      case CurseForgeGames.teso:
        return 455;
      case CurseForgeGames.darkestDungeon:
        return 608;
      case CurseForgeGames.amongUs:
        return 69761;
      case CurseForgeGames.kerbal:
        return 4401;
      case CurseForgeGames.terraria:
        return 431;
      case CurseForgeGames.worldoftanks:
        return 423;
      case CurseForgeGames.stardewvalley:
        return 669;
      case CurseForgeGames.minecraftDungeons:
        return 69271;
      case CurseForgeGames.sc2:
        return 65;
      case CurseForgeGames.wow:
        return 1;
      case CurseForgeGames.survivingMars:
        return 61489;
      case CurseForgeGames.rift:
        return 424;
    }
  }
}

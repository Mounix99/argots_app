// Podzols - Acidic soils found in cool, humid climates, typically under coniferous forests.
// Luvisols - Fertile soils with a clay-enriched subsoil, common in temperate climates and often used for agriculture.
// Cambisols - Soils with weakly developed profiles, usually found in a variety of climates and vegetation types.
// Chernozems - Very fertile, dark-colored soils found in temperate grasslands, rich in organic matter.
// Phaeozems - Similar to Chernozems but found in more humid areas, also very fertile and rich in organic matter.
// Gleysols - Waterlogged soils, often found in low-lying areas with poor drainage.
// Histosols - Organic soils, typically found in wetlands, peat bogs, and marshes.
// Regosols - Young soils with little profile development, usually found in areas with active erosion or deposition.
// Leptosols - Very shallow soils over hard rock or highly calcareous material, often found in mountainous regions.
// Vertisols - Clay-rich soils that swell and shrink significantly with moisture changes, creating deep cracks.
// Arenosols - Sandy soils with little profile development, often found in coastal areas and dunes.
// Fluvisols - Soils developed in alluvial deposits, typically found along rivers and floodplains.
// Kastanozems - Soils found in dry grassland regions, similar to Chernozems but in drier climates.
// Planosols - Soils with a distinct clay layer that impedes water drainage, often found in flat landscapes.
// Solonchaks - Saline soils found in arid and semi-arid regions.
// Solonetz - Soils with a high sodium content, often found in arid and semi-arid regions.
// Albeluvisols - Soils with a white, bleached horizon due to leaching, commonly found under forest cover.
// Acrisols - Acidic, nutrient-poor soils with a clay-enriched subsoil, typically found in humid, tropical, or subtropical regions.
// Andosols - Volcanic soils, rich in minerals and often very fertile, found in volcanic regions.
// Calcisols - Soils with significant accumulations of calcium carbonate, typically found in arid and semi-arid regions.
// Durisols - Soils with a hardpan of silica accumulation, found in arid and semi-arid regions.

import 'dart:ui';

enum SoilType {
  podzols,
  luvisols,
  cambisols,
  chernozems,
  phaeozems,
  gleysols,
  histosols,
  regosols,
  leptosols,
  vertisols,
  arenosols,
  fluvisols,
  kastanozems,
  planosols,
  solonchaks,
  solonetz,
  albeluvisols,
  acrisols,
  andosols,
  calcisols,
  durisols;

  String nameByLocal(Locale locale) {
    switch (locale.countryCode) {
      case 'en':
        return nameInEnglish;
      case 'uk':
        return nameInUkrainian;
      default:
        return nameInEnglish;
    }
  }

  String get nameInEnglish {
    switch (this) {
      case SoilType.podzols:
        return 'Podzols';
      case SoilType.luvisols:
        return 'Luvisols';
      case SoilType.cambisols:
        return 'Cambisols';
      case SoilType.chernozems:
        return 'Chernozems';
      case SoilType.phaeozems:
        return 'Phaeozems';
      case SoilType.gleysols:
        return 'Gleysols';
      case SoilType.histosols:
        return 'Histosols';
      case SoilType.regosols:
        return 'Regosols';
      case SoilType.leptosols:
        return 'Leptosols';
      case SoilType.vertisols:
        return 'Vertisols';
      case SoilType.arenosols:
        return 'Arenosols';
      case SoilType.fluvisols:
        return 'Fluvisols';
      case SoilType.kastanozems:
        return 'Kastanozems';
      case SoilType.planosols:
        return 'Planosols';
      case SoilType.solonchaks:
        return 'Solonchaks';
      case SoilType.solonetz:
        return 'Solonetz';
      case SoilType.albeluvisols:
        return 'Albeluvisols';
      case SoilType.acrisols:
        return 'Acrisols';
      case SoilType.andosols:
        return 'Andosols';
      case SoilType.calcisols:
        return 'Calcisols';
      case SoilType.durisols:
        return 'Durisols';
    }
  }

  String get nameInUkrainian {
    switch (this) {
      case SoilType.podzols:
        return 'Подзоли';
      case SoilType.luvisols:
        return 'Лувісоли';
      case SoilType.cambisols:
        return 'Камбісоли';
      case SoilType.chernozems:
        return 'Чорноземи';
      case SoilType.phaeozems:
        return 'Феоземи';
      case SoilType.gleysols:
        return 'Глейзоли';
      case SoilType.histosols:
        return 'Гістозоли';
      case SoilType.regosols:
        return 'Регозоли';
      case SoilType.leptosols:
        return 'Лептозоли';
      case SoilType.vertisols:
        return 'Вертісоли';
      case SoilType.arenosols:
        return 'Аренозоли';
      case SoilType.fluvisols:
        return 'Флювісоли';
      case SoilType.kastanozems:
        return 'Кастаноземи';
      case SoilType.planosols:
        return 'Планозоли';
      case SoilType.solonchaks:
        return 'Солончаки';
      case SoilType.solonetz:
        return 'Солонці';
      case SoilType.albeluvisols:
        return 'Альбелувісоли';
      case SoilType.acrisols:
        return 'Акрісоли';
      case SoilType.andosols:
        return 'Андозоли';
      case SoilType.calcisols:
        return 'Кальцісоли';
      case SoilType.durisols:
        return 'Дурісоли';
    }
  }

  static SoilType fromString(String? value) {
    switch (value) {
      case 'podzols':
        return SoilType.podzols;
      case 'luvisols':
        return SoilType.luvisols;
      case 'cambisols':
        return SoilType.cambisols;
      case 'chernozems':
        return SoilType.chernozems;
      case 'phaeozems':
        return SoilType.phaeozems;
      case 'gleysols':
        return SoilType.gleysols;
      case 'histosols':
        return SoilType.histosols;
      case 'regosols':
        return SoilType.regosols;
      case 'leptosols':
        return SoilType.leptosols;
      case 'vertisols':
        return SoilType.vertisols;
      case 'arenosols':
        return SoilType.arenosols;
      case 'fluvisols':
        return SoilType.fluvisols;
      case 'kastanozems':
        return SoilType.kastanozems;
      case 'planosols':
        return SoilType.planosols;
      case 'solonchaks':
        return SoilType.solonchaks;
      case 'solonetz':
        return SoilType.solonetz;
      case 'albeluvisols':
        return SoilType.albeluvisols;
      case 'acrisols':
        return SoilType.acrisols;
      case 'andosols':
        return SoilType.andosols;
      case 'calcisols':
        return SoilType.calcisols;
      case 'burisols':
        return SoilType.durisols;
      default:
        throw Exception('Unknown soil type');
    }
  }
}

import 'package:domain/system_values/entities/growth_season.dart';

import '../dto/growth_season_dto.dart';

extension GrowthSeasonDtoMapper on GrowthSeasonDto {
  GrowthSeason toDomain() => GrowthSeason(
        id: id,
        value: value,
        label: label,
        description: description,
        monthStart: monthStart,
        monthEnd: monthEnd,
        sortOrder: sortOrder,
      );
}

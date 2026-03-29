import 'package:domain/system_values/entities/soil_type.dart';

import '../dto/soil_type_dto.dart';

extension SoilTypeDtoMapper on SoilTypeDto {
  SoilType toDomain() => SoilType(
        id: id,
        value: value,
        label: label,
        description: description,
        phMin: phMin,
        phMax: phMax,
        sortOrder: sortOrder,
      );
}

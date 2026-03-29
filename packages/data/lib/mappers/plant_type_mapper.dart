import 'package:domain/system_values/entities/plant_type.dart';

import '../dto/plant_type_dto.dart';

extension PlantTypeDtoMapper on PlantTypeDto {
  PlantType toDomain() => PlantType(
        id: id,
        value: value,
        label: label,
        description: description,
        sortOrder: sortOrder,
      );
}

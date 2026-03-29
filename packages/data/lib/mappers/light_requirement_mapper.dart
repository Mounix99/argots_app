import 'package:domain/system_values/entities/light_requirement.dart';

import '../dto/light_requirement_dto.dart';

extension LightRequirementDtoMapper on LightRequirementDto {
  LightRequirement toDomain() => LightRequirement(
        id: id,
        value: value,
        label: label,
        description: description,
        minHours: minHours,
        maxHours: maxHours,
        sortOrder: sortOrder,
      );
}

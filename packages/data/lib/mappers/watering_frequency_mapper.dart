import 'package:domain/system_values/entities/watering_frequency.dart';

import '../dto/watering_frequency_dto.dart';

extension WateringFrequencyDtoMapper on WateringFrequencyDto {
  WateringFrequency toDomain() => WateringFrequency(
        id: id,
        value: value,
        label: label,
        description: description,
        intervalDaysMin: intervalDaysMin,
        intervalDaysMax: intervalDaysMax,
        sortOrder: sortOrder,
      );
}

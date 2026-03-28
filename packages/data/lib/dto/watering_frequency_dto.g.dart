// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watering_frequency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WateringFrequencyDto _$WateringFrequencyDtoFromJson(
  Map<String, dynamic> json,
) => WateringFrequencyDto(
  id: (json['id'] as num).toInt(),
  value: json['value'] as String,
  label: json['label'] as String,
  description: json['description'] as String?,
  intervalDaysMin: (json['interval_days_min'] as num?)?.toInt(),
  intervalDaysMax: (json['interval_days_max'] as num?)?.toInt(),
  sortOrder: (json['sort_order'] as num).toInt(),
);

Map<String, dynamic> _$WateringFrequencyDtoToJson(
  WateringFrequencyDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'value': instance.value,
  'label': instance.label,
  'description': instance.description,
  'interval_days_min': instance.intervalDaysMin,
  'interval_days_max': instance.intervalDaysMax,
  'sort_order': instance.sortOrder,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_requirement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightRequirementDto _$LightRequirementDtoFromJson(Map<String, dynamic> json) =>
    LightRequirementDto(
      id: (json['id'] as num).toInt(),
      value: json['value'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      minHours: (json['min_hours'] as num?)?.toInt(),
      maxHours: (json['max_hours'] as num?)?.toInt(),
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$LightRequirementDtoToJson(
  LightRequirementDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'value': instance.value,
  'label': instance.label,
  'description': instance.description,
  'min_hours': instance.minHours,
  'max_hours': instance.maxHours,
  'sort_order': instance.sortOrder,
};

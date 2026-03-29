// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soil_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoilTypeDto _$SoilTypeDtoFromJson(Map<String, dynamic> json) => SoilTypeDto(
  id: (json['id'] as num).toInt(),
  value: json['value'] as String,
  label: json['label'] as String,
  description: json['description'] as String?,
  phMin: (json['ph_min'] as num?)?.toDouble(),
  phMax: (json['ph_max'] as num?)?.toDouble(),
  sortOrder: (json['sort_order'] as num).toInt(),
);

Map<String, dynamic> _$SoilTypeDtoToJson(SoilTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'ph_min': instance.phMin,
      'ph_max': instance.phMax,
      'sort_order': instance.sortOrder,
    };

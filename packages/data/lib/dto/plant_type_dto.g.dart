// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantTypeDto _$PlantTypeDtoFromJson(Map<String, dynamic> json) => PlantTypeDto(
  id: (json['id'] as num).toInt(),
  value: json['value'] as String,
  label: json['label'] as String,
  description: json['description'] as String?,
  sortOrder: (json['sort_order'] as num).toInt(),
);

Map<String, dynamic> _$PlantTypeDtoToJson(PlantTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'sort_order': instance.sortOrder,
    };

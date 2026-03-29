// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_season_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowthSeasonDto _$GrowthSeasonDtoFromJson(Map<String, dynamic> json) =>
    GrowthSeasonDto(
      id: (json['id'] as num).toInt(),
      value: json['value'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      monthStart: (json['month_start'] as num?)?.toInt(),
      monthEnd: (json['month_end'] as num?)?.toInt(),
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$GrowthSeasonDtoToJson(GrowthSeasonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'label': instance.label,
      'description': instance.description,
      'month_start': instance.monthStart,
      'month_end': instance.monthEnd,
      'sort_order': instance.sortOrder,
    };

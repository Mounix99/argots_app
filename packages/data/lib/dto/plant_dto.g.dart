// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantDto _$PlantDtoFromJson(Map<String, dynamic> json) => PlantDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  authorId: json['author_id'] as String,
  soilType: (json['soil_type'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  usedBy: (json['used_by'] as List<dynamic>?)?.map((e) => e as String).toList(),
  plantType: (json['plant_type'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  public: json['public'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
  lastUpdateAt: json['last_update_at'] == null
      ? null
      : DateTime.parse(json['last_update_at'] as String),
  version: json['version'] as String,
  photoUrl: json['photo_url'] as String?,
  lightRequirements: json['light_requirements'] as String?,
  wateringFrequency: json['watering_frequency'] as String?,
  growthSeasons: (json['growth_seasons'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$PlantDtoToJson(PlantDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'author_id': instance.authorId,
  'soil_type': instance.soilType,
  'used_by': instance.usedBy,
  'plant_type': instance.plantType,
  'public': instance.public,
  'created_at': instance.createdAt.toIso8601String(),
  'last_update_at': instance.lastUpdateAt?.toIso8601String(),
  'version': instance.version,
  'photo_url': instance.photoUrl,
  'light_requirements': instance.lightRequirements,
  'watering_frequency': instance.wateringFrequency,
  'growth_seasons': instance.growthSeasons,
};

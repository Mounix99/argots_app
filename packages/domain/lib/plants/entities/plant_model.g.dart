// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantModel _$PlantModelFromJson(Map<String, dynamic> json) => PlantModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      authorId: json['author_id'] as String,
      soilType: (json['soil_type'] as List<dynamic>?)?.map((e) => e as String),
      usedBy: (json['used_by'] as List<dynamic>?)?.map((e) => e as String).toList(),
      plantType: (json['plant_type'] as List<dynamic>?)?.map((e) => e as String),
      public: json['public'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastUpdateAt: DateTime.parse(json['last_update_at'] as String),
      version: json['version'] as String,
      photoUrl: json['photo_url'] as String?,
    );

Map<String, dynamic> _$PlantModelToJson(PlantModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'author_id': instance.authorId,
      'soil_type': instance.soilType?.toList(),
      'used_by': instance.usedBy,
      'plant_type': instance.plantType?.toList(),
      'public': instance.public,
      'created_at': instance.createdAt.toIso8601String(),
      'last_update_at': instance.lastUpdateAt.toIso8601String(),
      'version': instance.version,
      'photo_url': instance.photoUrl,
    };

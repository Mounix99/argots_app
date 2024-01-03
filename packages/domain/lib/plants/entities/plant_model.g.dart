// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantModel _$PlantModelFromJson(Map<String, dynamic> json) => PlantModel(
      plantId: json['plant_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      authorId: json['author_id'] as int,
      stagesLength: json['stages_length'] as int?,
      soilTypes: (json['soil_types'] as List<dynamic>).map((e) => e as String).toList(),
      usesByUsersId: (json['uses_by_users_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      plantType: json['plant_type'] as String,
      public: json['public'] as bool,
      timesAddedByUsers: json['times_added_by_users'] as int?,
      createDate: DateTime.parse(json['create_date'] as String),
      lastUpdateDate: DateTime.parse(json['last_update_date'] as String),
      version: json['version'] as String,
      photoPath: json['photo_path'] as String?,
      stagesId: (json['stages_id'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PlantModelToJson(PlantModel instance) => <String, dynamic>{
      'plant_id': instance.plantId,
      'title': instance.title,
      'description': instance.description,
      'author_id': instance.authorId,
      'stages_length': instance.stagesLength,
      'soil_types': instance.soilTypes,
      'uses_by_users_id': instance.usesByUsersId,
      'plant_type': instance.plantType,
      'public': instance.public,
      'times_added_by_users': instance.timesAddedByUsers,
      'create_date': instance.createDate.toIso8601String(),
      'last_update_date': instance.lastUpdateDate.toIso8601String(),
      'version': instance.version,
      'photo_path': instance.photoPath,
      'stages_id': instance.stagesId,
    };

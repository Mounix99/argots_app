// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageDto _$StageDtoFromJson(Map<String, dynamic> json) => StageDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  lastUpdateAt: DateTime.parse(json['last_update_at'] as String),
  plantId: (json['plant_id'] as num).toInt(),
  authorId: json['author_id'] as String,
  duration: (json['duration'] as num).toInt(),
);

Map<String, dynamic> _$StageDtoToJson(StageDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
  'last_update_at': instance.lastUpdateAt.toIso8601String(),
  'plant_id': instance.plantId,
  'author_id': instance.authorId,
  'duration': instance.duration,
};

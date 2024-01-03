// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageModel _$StageModelFromJson(Map<String, dynamic> json) => StageModel(
      plantDocId: json['plant_doc_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      authorDocId: json['author_doc_id'] as String,
      durationDelta: json['duration_delta'] as int?,
      stageDocId: json['stage_doc_id'] as String?,
    );

Map<String, dynamic> _$StageModelToJson(StageModel instance) => <String, dynamic>{
      'plant_doc_id': instance.plantDocId,
      'title': instance.title,
      'description': instance.description,
      'author_doc_id': instance.authorDocId,
      'duration_delta': instance.durationDelta,
      'stage_doc_id': instance.stageDocId,
    };

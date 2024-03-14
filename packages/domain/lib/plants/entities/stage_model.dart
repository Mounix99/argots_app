import 'package:json_annotation/json_annotation.dart';

part 'stage_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StageModel {
  final int id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime lastUpdateAt;
  final int plantId;
  final String authorId;
  final int duration;

  const StageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.plantId,
    required this.authorId,
    required this.duration,
  });

  Map<String, dynamic> toJson() => _$StageModelToJson(this);

  factory StageModel.fromJson(Map<String, dynamic> json) => _$StageModelFromJson(json);
}

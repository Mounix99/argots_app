import 'package:json_annotation/json_annotation.dart';

part 'stage_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StageModel {
  final String plantDocId;
  final String title;
  final String? description;
  final String authorDocId;
  final int? durationDelta;
  final String? stageDocId;

  const StageModel(
      {required this.plantDocId,
      required this.title,
      this.description,
      required this.authorDocId,
      this.durationDelta,
      this.stageDocId});

  Map<String, dynamic> toJson() => _$StageModelToJson(this);

  factory StageModel.fromJson(Map<String, dynamic> json) => _$StageModelFromJson(json);
}

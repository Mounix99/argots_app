import 'package:json_annotation/json_annotation.dart';

part 'stage_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StageDto {
  final int id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime lastUpdateAt;
  final int plantId;
  final String authorId;
  final int duration;

  const StageDto({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.plantId,
    required this.authorId,
    required this.duration,
  });

  factory StageDto.fromJson(Map<String, dynamic> json) => _$StageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StageDtoToJson(this);
}

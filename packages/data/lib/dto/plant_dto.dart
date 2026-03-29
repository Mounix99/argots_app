import 'package:json_annotation/json_annotation.dart';

part 'plant_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlantDto {
  final int id;
  final String title;
  final String? description;
  final String authorId;
  final List<String>? soilType;
  final List<String>? usedBy;
  final List<String>? plantType;
  final bool public;
  final DateTime createdAt;
  final DateTime? lastUpdateAt;
  final String version;
  final String? photoUrl;
  final String? lightRequirements;
  final String? wateringFrequency;
  final List<String>? growthSeasons;

  const PlantDto({
    required this.id,
    required this.title,
    this.description,
    required this.authorId,
    this.soilType,
    this.usedBy,
    this.plantType,
    required this.public,
    required this.createdAt,
    this.lastUpdateAt,
    required this.version,
    this.photoUrl,
    this.lightRequirements,
    this.wateringFrequency,
    this.growthSeasons,
  });

  factory PlantDto.fromJson(Map<String, dynamic> json) => _$PlantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlantDtoToJson(this);
}

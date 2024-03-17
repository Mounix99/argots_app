import 'package:json_annotation/json_annotation.dart';

part 'plant_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlantModel {
  final int id;
  final String title;
  final String? description;
  final String authorId;
  final Iterable<String>? soilType;
  final List<String>? usedBy;
  final Iterable<String>? plantType;
  final bool public;
  final DateTime createdAt;
  final DateTime? lastUpdateAt;
  final String version;
  final String? photoUrl;

  PlantModel(
      {required this.id,
      required this.title,
      this.description,
      required this.authorId,
      this.soilType,
      this.usedBy,
      this.plantType,
      required this.public,
      required this.createdAt,
      required this.lastUpdateAt,
      required this.version,
      this.photoUrl});

  Map<String, dynamic> toJson() => _$PlantModelToJson(this);

  factory PlantModel.fromJson(Map<String, dynamic> json) => _$PlantModelFromJson(json);
}

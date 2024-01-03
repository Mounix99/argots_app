import 'package:json_annotation/json_annotation.dart';

part 'plant_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlantModel {
  final int plantId;
  final String title;
  final String? description;
  final int authorId;
  final int? stagesLength;
  final List<String> soilTypes;
  final List<String>? usesByUsersId;
  final String plantType;
  final bool public;
  final int? timesAddedByUsers;
  final DateTime createDate;
  final DateTime lastUpdateDate;
  final String version;
  final String? photoPath;
  final List<String> stagesId;

  PlantModel(
      {required this.plantId,
      required this.title,
      this.description,
      required this.authorId,
      this.stagesLength,
      required this.soilTypes,
      this.usesByUsersId,
      required this.plantType,
      required this.public,
      this.timesAddedByUsers,
      required this.createDate,
      required this.lastUpdateDate,
      required this.version,
      this.photoPath,
      required this.stagesId});

  Map<String, dynamic> toJson() => _$PlantModelToJson(this);
}

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

  PlantModel copyWith({
    int? id,
    String? title,
    String? description,
    String? authorId,
    Iterable<String>? soilType,
    List<String>? usedBy,
    Iterable<String>? plantType,
    bool? public,
    DateTime? createdAt,
    DateTime? lastUpdateAt,
    String? version,
    String? photoUrl,
  }) {
    return PlantModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      authorId: authorId ?? this.authorId,
      soilType: soilType ?? this.soilType,
      usedBy: usedBy ?? this.usedBy,
      plantType: plantType ?? this.plantType,
      public: public ?? this.public,
      createdAt: createdAt ?? this.createdAt,
      lastUpdateAt: lastUpdateAt ?? this.lastUpdateAt,
      version: version ?? this.version,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

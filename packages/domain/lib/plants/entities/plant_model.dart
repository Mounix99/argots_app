import 'package:equatable/equatable.dart';

class PlantModel extends Equatable {
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

  const PlantModel({
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
  });

  PlantModel copyWith({
    int? id,
    String? title,
    String? description,
    String? authorId,
    List<String>? soilType,
    List<String>? usedBy,
    List<String>? plantType,
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

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        authorId,
        soilType,
        usedBy,
        plantType,
        public,
        createdAt,
        lastUpdateAt,
        version,
        photoUrl,
      ];
}

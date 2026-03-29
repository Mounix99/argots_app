import 'package:json_annotation/json_annotation.dart';

part 'plant_type_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlantTypeDto {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int sortOrder;

  const PlantTypeDto({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    required this.sortOrder,
  });

  factory PlantTypeDto.fromJson(Map<String, dynamic> json) => _$PlantTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlantTypeDtoToJson(this);
}

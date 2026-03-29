import 'package:json_annotation/json_annotation.dart';

part 'soil_type_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SoilTypeDto {
  final int id;
  final String value;
  final String label;
  final String? description;
  final double? phMin;
  final double? phMax;
  final int sortOrder;

  const SoilTypeDto({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.phMin,
    this.phMax,
    required this.sortOrder,
  });

  factory SoilTypeDto.fromJson(Map<String, dynamic> json) => _$SoilTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SoilTypeDtoToJson(this);
}

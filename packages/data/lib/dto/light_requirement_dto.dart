import 'package:json_annotation/json_annotation.dart';

part 'light_requirement_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LightRequirementDto {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? minHours;
  final int? maxHours;
  final int sortOrder;

  const LightRequirementDto({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.minHours,
    this.maxHours,
    required this.sortOrder,
  });

  factory LightRequirementDto.fromJson(Map<String, dynamic> json) => _$LightRequirementDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LightRequirementDtoToJson(this);
}

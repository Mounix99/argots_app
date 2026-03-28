import 'package:json_annotation/json_annotation.dart';

part 'growth_season_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GrowthSeasonDto {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? monthStart;
  final int? monthEnd;
  final int sortOrder;

  const GrowthSeasonDto({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.monthStart,
    this.monthEnd,
    required this.sortOrder,
  });

  factory GrowthSeasonDto.fromJson(Map<String, dynamic> json) => _$GrowthSeasonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GrowthSeasonDtoToJson(this);
}

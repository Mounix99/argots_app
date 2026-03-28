import 'package:json_annotation/json_annotation.dart';

part 'watering_frequency_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WateringFrequencyDto {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? intervalDaysMin;
  final int? intervalDaysMax;
  final int sortOrder;

  const WateringFrequencyDto({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.intervalDaysMin,
    this.intervalDaysMax,
    required this.sortOrder,
  });

  factory WateringFrequencyDto.fromJson(Map<String, dynamic> json) => _$WateringFrequencyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WateringFrequencyDtoToJson(this);
}

import 'package:equatable/equatable.dart';

class WateringFrequency extends Equatable {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? intervalDaysMin;
  final int? intervalDaysMax;
  final int sortOrder;

  const WateringFrequency({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.intervalDaysMin,
    this.intervalDaysMax,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, value, label, description, intervalDaysMin, intervalDaysMax, sortOrder];
}

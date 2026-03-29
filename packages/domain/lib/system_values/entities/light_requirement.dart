import 'package:equatable/equatable.dart';

class LightRequirement extends Equatable {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? minHours;
  final int? maxHours;
  final int sortOrder;

  const LightRequirement({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.minHours,
    this.maxHours,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, value, label, description, minHours, maxHours, sortOrder];
}

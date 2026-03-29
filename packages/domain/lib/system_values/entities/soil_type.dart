import 'package:equatable/equatable.dart';

class SoilType extends Equatable {
  final int id;
  final String value;
  final String label;
  final String? description;
  final double? phMin;
  final double? phMax;
  final int sortOrder;

  const SoilType({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.phMin,
    this.phMax,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, value, label, description, phMin, phMax, sortOrder];
}

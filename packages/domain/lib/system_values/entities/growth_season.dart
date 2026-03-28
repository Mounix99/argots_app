import 'package:equatable/equatable.dart';

class GrowthSeason extends Equatable {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int? monthStart;
  final int? monthEnd;
  final int sortOrder;

  const GrowthSeason({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    this.monthStart,
    this.monthEnd,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, value, label, description, monthStart, monthEnd, sortOrder];
}

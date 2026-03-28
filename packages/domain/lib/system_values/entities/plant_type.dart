import 'package:equatable/equatable.dart';

class PlantType extends Equatable {
  final int id;
  final String value;
  final String label;
  final String? description;
  final int sortOrder;

  const PlantType({
    required this.id,
    required this.value,
    required this.label,
    this.description,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [id, value, label, description, sortOrder];
}

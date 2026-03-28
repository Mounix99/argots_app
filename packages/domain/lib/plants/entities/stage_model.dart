import 'package:equatable/equatable.dart';

class StageModel extends Equatable {
  final int id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime lastUpdateAt;
  final int plantId;
  final String authorId;
  final int duration;

  const StageModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.plantId,
    required this.authorId,
    required this.duration,
  });

  @override
  List<Object?> get props => [id, title, description, createdAt, lastUpdateAt, plantId, authorId, duration];
}

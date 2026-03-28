import 'package:domain/plants/entities/stage_model.dart';

import '../dto/stage_dto.dart';

extension StageDtoMapper on StageDto {
  StageModel toDomain() => StageModel(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
        lastUpdateAt: lastUpdateAt,
        plantId: plantId,
        authorId: authorId,
        duration: duration,
      );
}

extension StageModelMapper on StageModel {
  StageDto toDto() => StageDto(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
        lastUpdateAt: lastUpdateAt,
        plantId: plantId,
        authorId: authorId,
        duration: duration,
      );
}

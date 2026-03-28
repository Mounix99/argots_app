import 'package:domain/plants/entities/plant_model.dart';

import '../dto/plant_dto.dart';

extension PlantDtoMapper on PlantDto {
  PlantModel toDomain() => PlantModel(
        id: id,
        title: title,
        description: description,
        authorId: authorId,
        soilType: soilType,
        usedBy: usedBy,
        plantType: plantType,
        public: public,
        createdAt: createdAt,
        lastUpdateAt: lastUpdateAt,
        version: version,
        photoUrl: photoUrl,
        lightRequirements: lightRequirements,
        wateringFrequency: wateringFrequency,
        growthSeasons: growthSeasons,
      );
}

extension PlantModelMapper on PlantModel {
  PlantDto toDto() => PlantDto(
        id: id,
        title: title,
        description: description,
        authorId: authorId,
        soilType: soilType,
        usedBy: usedBy,
        plantType: plantType,
        public: public,
        createdAt: createdAt,
        lastUpdateAt: lastUpdateAt,
        version: version,
        photoUrl: photoUrl,
        lightRequirements: lightRequirements,
        wateringFrequency: wateringFrequency,
        growthSeasons: growthSeasons,
      );
}

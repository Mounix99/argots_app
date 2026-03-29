import '../dto/plant_dto.dart';
import '../dto/stage_dto.dart';

abstract class PlantRemoteDataSource {
  /// Plants

  Future<PlantDto> getPlantInfo({required int plantId});

  Future<PlantDto> addPlant({required Map<String, dynamic> plantData});

  Future<void> updatePlant({required int plantId, required Map<String, dynamic> plantData});

  Future<void> deletePlant({required int plantId});

  Future<List<PlantDto>> getMarketPlants({required int offset, required int limit});

  Future<List<PlantDto>> getPlantsCreatedByUser({required String userId, required int offset, required int limit});

  Future<List<PlantDto>> getUserPlants({required String userId, required int offset, required int limit});

  /// Stages

  Future<void> addStage({required Map<String, dynamic> stageData});

  Future<void> updateStage({required int stageId, required Map<String, dynamic> stageData});

  Future<void> deleteStage({required int stageId});

  Future<List<StageDto>> getListOfStages({required int plantId, required int offset, required int limit});

  Future<StageDto> getStageInfo({required int stageId});
}

import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/success_objects/success_object.dart';
import '../entities/plant_model.dart';
import '../entities/stage_model.dart';

abstract class PlantsRepository {
  Future<Either<Failure, Success>> addPlant({required Map<String, dynamic> plantData});

  Future<Either<Failure, Success>> updatePlant({required int plantId, required Map<String, dynamic> plantData});

  Future<Either<Failure, Success>> deletePlant({required int plantId});

  Future<Either<Failure, List<PlantModel>>> getPlantsCreatedByMe({List<int>? plantIds});

  Future<Either<Failure, List<PlantModel>>> getUserPlants({required int userId});

  Future<Either<Failure, List<PlantModel>>> getMarketPlants();

  Future<Either<Failure, PlantModel>> getPlantInfo({required int plantId});

  Future<Either<Failure, Success>> addStage({required Map<String, dynamic> stageData});

  Future<Either<Failure, Success>> updateStage({required int stageId, required Map<String, dynamic> stageData});

  Future<Either<Failure, Success>> deleteStage({required int stageId});

  Future<Either<Failure, List<StageModel>>> getListOfStages({required int plantId});

  Future<Either<Failure, StageModel>> getStageInfo({required int stageId});
}

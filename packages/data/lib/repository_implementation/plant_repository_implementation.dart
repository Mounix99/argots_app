import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';

import '../mappers/plant_mapper.dart';
import '../mappers/stage_mapper.dart';
import '../remote_data_source/plant_remote_data_source.dart';

class PlantRepositoryImplementation implements PlantsRepository {
  final PlantRemoteDataSource _remoteDataSource;

  PlantRepositoryImplementation({required PlantRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  /// Plants

  @override
  Future<Either<Failure, PlantModel>> getPlantInfo({required int plantId}) async {
    try {
      final dto = await _remoteDataSource.getPlantInfo(plantId: plantId);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> addPlant({required PlantModel plant}) async {
    try {
      await _remoteDataSource.addPlant(plantData: plant.toDto().toJson());
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> updatePlant({required PlantModel plant}) async {
    try {
      await _remoteDataSource.updatePlant(plantId: plant.id, plantData: plant.toDto().toJson());
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> deletePlant({required int plantId}) async {
    try {
      await _remoteDataSource.deletePlant(plantId: plantId);
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getMarketPlants({required int page, required int size}) async {
    final offset = (page - 1) * size;
    try {
      final dtos = await _remoteDataSource.getMarketPlants(offset: offset, limit: size);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getPlantsCreatedByUser(
      {required String userId, required int page, required int size}) async {
    final offset = (page - 1) * size;
    try {
      final dtos = await _remoteDataSource.getPlantsCreatedByUser(userId: userId, offset: offset, limit: size);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getUserPlants(
      {required String userId, required int page, required int size}) async {
    final offset = (page - 1) * size;
    try {
      final dtos = await _remoteDataSource.getUserPlants(userId: userId, offset: offset, limit: size);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  /// Stages

  @override
  Future<Either<Failure, Success>> addStage({required StageModel stage}) async {
    try {
      await _remoteDataSource.addStage(stageData: stage.toDto().toJson());
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> updateStage({required StageModel stage}) async {
    try {
      await _remoteDataSource.updateStage(stageId: stage.id, stageData: stage.toDto().toJson());
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteStage({required int stageId}) async {
    try {
      await _remoteDataSource.deleteStage(stageId: stageId);
      return Right(RemoteSourceSuccess());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<StageModel>>> getListOfStages(
      {required int plantId, required int page, required int size}) async {
    final offset = (page - 1) * size;
    try {
      final dtos = await _remoteDataSource.getListOfStages(plantId: plantId, offset: offset, limit: size);
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, StageModel>> getStageInfo({required int stageId}) async {
    try {
      final dto = await _remoteDataSource.getStageInfo(stageId: stageId);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> addPlantToUser({required int plantId, required String userId}) async {
    try {
      final plantResult = await getPlantInfo(plantId: plantId);
      return plantResult.fold(
        Left.new,
        (plant) async {
          final usedBy = List<String>.from(plant.usedBy ?? []);
          if (!usedBy.contains(userId)) {
            usedBy.add(userId);
          }
          return updatePlant(plant: plant.copyWith(usedBy: usedBy));
        },
      );
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, Success>> removePlantFromUser({required int plantId, required String userId}) async {
    try {
      final plantResult = await getPlantInfo(plantId: plantId);
      return plantResult.fold(
        Left.new,
        (plant) async {
          final usedBy = List<String>.from(plant.usedBy ?? []);
          usedBy.remove(userId);
          return updatePlant(plant: plant.copyWith(usedBy: usedBy));
        },
      );
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }
}

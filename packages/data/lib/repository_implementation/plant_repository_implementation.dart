import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlantRepositoryImplementation implements PlantsRepository {
  static const String _plantTable = 'plants';
  static const String _stageTable = 'stages';

  final Supabase supabase;

  PlantRepositoryImplementation(this.supabase);

  /// Plants
  @override
  Future<Either<Failure, PlantModel>> getPlantInfo({required int plantId}) async {
    try {
      final response = await supabase.client.from(_plantTable).select().eq('id', plantId);
      if (response.length > 1) {
        return Future.value(const Left(RemoteSourceFailure(remoteError: 'More than one plant with the same id')));
      } else if (response.isNotEmpty) {
        final plant = PlantModel.fromJson(response.first);
        return Future.value(Right(plant));
      } else {
        return Future.value(const Left(RemoteSourceFailure(remoteError: 'No plant with the given id')));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, Success>> addPlant({required Map<String, dynamic> plantData}) async {
    try {
      await supabase.client.from(_plantTable).insert(plantData);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, Success>> updatePlant({required int plantId, required Map<String, dynamic> plantData}) async {
    try {
      await supabase.client.from(_plantTable).update(plantData).eq('id', plantId);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, Success>> deletePlant({required int plantId}) async {
    try {
      await supabase.client.from(_plantTable).delete().eq('id', plantId);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getMarketPlants({required int page}) async {
    try {
      final response = await supabase.client.from(_plantTable).select().eq('public', true);
      if (response.isNotEmpty) {
        final plants = response.map((e) => PlantModel.fromJson(e)).toList();
        return Future.value(Right(plants));
      } else {
        return Future.value(const Right([]));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getPlantsCreatedByUser({required String userId, required int page}) async {
    try {
      final response = await supabase.client.from(_plantTable).select().eq('author_id', userId);
      if (response.isNotEmpty) {
        final plants = response.map((e) => PlantModel.fromJson(e)).toList();
        return Future.value(Right(plants));
      } else {
        return Future.value(const Right([]));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, List<PlantModel>>> getUserPlants({required String userId, required int page}) async {
    try {
      final response = await supabase.client.from(_plantTable).select().contains('used_by', userId);
      if (response.isNotEmpty) {
        final plants = response.map((e) => PlantModel.fromJson(e)).toList();
        return Future.value(Right(plants));
      } else {
        return Future.value(const Right([]));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  /// Stages
  @override
  Future<Either<Failure, Success>> addStage({required Map<String, dynamic> stageData}) async {
    try {
      await supabase.client.from(_stageTable).insert(stageData);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, Success>> updateStage({required int stageId, required Map<String, dynamic> stageData}) async {
    try {
      await supabase.client.from(_stageTable).update(stageData).eq('id', stageId);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, Success>> deleteStage({required int stageId}) async {
    try {
      await supabase.client.from(_stageTable).delete().eq('id', stageId);
      return Future.value(Right(RemoteSourceSuccess()));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, List<StageModel>>> getListOfStages({required int plantId, required int page}) async {
    try {
      final response = await supabase.client.from(_stageTable).select().eq('plant_id', plantId);
      if (response.isNotEmpty) {
        final stages = response.map(StageModel.fromJson).toList();
        return Future.value(Right(stages));
      } else {
        return Future.value(const Right([]));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }

  @override
  Future<Either<Failure, StageModel>> getStageInfo({required int stageId}) async {
    try {
      final response = await supabase.client.from(_stageTable).select().eq('id', stageId);
      if (response.length > 1) {
        return Future.value(const Left(RemoteSourceFailure(remoteError: 'More than one stage with the same id')));
      } else if (response.isNotEmpty) {
        return Future.value(Right(StageModel.fromJson(response.first)));
      } else {
        return Future.value(const Left(RemoteSourceFailure(remoteError: 'No stage with the given id')));
      }
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e)));
    }
  }
}

import 'package:domain/core/errors/failure.dart';
import 'package:domain/system_values/entities/growth_season.dart';
import 'package:domain/system_values/entities/light_requirement.dart';
import 'package:domain/system_values/entities/plant_type.dart';
import 'package:domain/system_values/entities/soil_type.dart';
import 'package:domain/system_values/entities/watering_frequency.dart';
import 'package:domain/system_values/repositories/system_values_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../mappers/growth_season_mapper.dart';
import '../mappers/light_requirement_mapper.dart';
import '../mappers/plant_type_mapper.dart';
import '../mappers/soil_type_mapper.dart';
import '../mappers/watering_frequency_mapper.dart';
import '../remote_data_source/system_values_remote_data_source.dart';

class SystemValuesRepositoryImplementation implements SystemValuesRepository {
  final SystemValuesRemoteDataSource _remoteDataSource;

  SystemValuesRepositoryImplementation({required SystemValuesRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<SoilType>>> getSoilTypes() async {
    try {
      final dtos = await _remoteDataSource.getSoilTypes();
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<PlantType>>> getPlantTypes() async {
    try {
      final dtos = await _remoteDataSource.getPlantTypes();
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<LightRequirement>>> getLightRequirements() async {
    try {
      final dtos = await _remoteDataSource.getLightRequirements();
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<WateringFrequency>>> getWateringFrequencies() async {
    try {
      final dtos = await _remoteDataSource.getWateringFrequencies();
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }

  @override
  Future<Either<Failure, List<GrowthSeason>>> getGrowthSeasons() async {
    try {
      final dtos = await _remoteDataSource.getGrowthSeasons();
      return Right(dtos.map((dto) => dto.toDomain()).toList());
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e));
    }
  }
}

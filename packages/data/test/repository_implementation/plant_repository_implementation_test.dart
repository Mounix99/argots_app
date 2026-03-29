import 'package:data/dto/plant_dto.dart';
import 'package:data/dto/stage_dto.dart';
import 'package:data/remote_data_source/plant_remote_data_source.dart';
import 'package:data/repository_implementation/plant_repository_implementation.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'plant_repository_implementation_test.mocks.dart';

// Typed helper to avoid `Right<dynamic, T>` vs `Right<Failure, T>` mismatch.
Matcher rightWith<T>(T value) => equals(Right<Failure, T>(value));

final _now = DateTime(2024, 1, 1);

final _tPlantDto = PlantDto(
  id: 1,
  title: 'Test Plant',
  description: 'Description',
  authorId: 'author-1',
  soilType: null,
  usedBy: null,
  plantType: null,
  public: true,
  createdAt: _now,
  lastUpdateAt: null,
  version: '1.0',
  photoUrl: null,
);

final _tPlantModel = PlantModel(
  id: 1,
  title: 'Test Plant',
  description: 'Description',
  authorId: 'author-1',
  soilType: null,
  usedBy: null,
  plantType: null,
  public: true,
  createdAt: _now,
  lastUpdateAt: null,
  version: '1.0',
  photoUrl: null,
);

final _tStageDto = StageDto(
  id: 1,
  title: 'Test Stage',
  description: null,
  createdAt: _now,
  lastUpdateAt: _now,
  plantId: 1,
  authorId: 'author-1',
  duration: 30,
);

final _tStageModel = StageModel(
  id: 1,
  title: 'Test Stage',
  description: null,
  createdAt: _now,
  lastUpdateAt: _now,
  plantId: 1,
  authorId: 'author-1',
  duration: 30,
);

@GenerateNiceMocks([MockSpec<PlantRemoteDataSource>(as: #MockPlantRemoteDataSource)])
void main() {
  late MockPlantRemoteDataSource mockDataSource;
  late PlantRepositoryImplementation repository;

  setUp(() {
    provideDummy<Either<Failure, Success>>(Right(RemoteSourceSuccess()));
    provideDummy<Either<Failure, PlantModel>>(const Left(RemoteSourceFailure()));
    mockDataSource = MockPlantRemoteDataSource();
    repository = PlantRepositoryImplementation(remoteDataSource: mockDataSource);
  });

  group('PlantRepositoryImplementation/getPlantInfo', () {
    test('/Success/ = maps PlantDto to PlantModel', () async {
      when(mockDataSource.getPlantInfo(plantId: anyNamed('plantId')))
          .thenAnswer((_) async => _tPlantDto);

      final result = await repository.getPlantInfo(plantId: 1);

      expect(result, rightWith(_tPlantModel));
    });

    test('/Failure/ = wraps exception in RemoteSourceFailure', () async {
      when(mockDataSource.getPlantInfo(plantId: anyNamed('plantId')))
          .thenThrow(Exception('not found'));

      final result = await repository.getPlantInfo(plantId: 1);

      expect(result.isLeft(), true);
    });
  });

  group('PlantRepositoryImplementation/getMarketPlants', () {
    const page = 1;
    const size = 20;

    test('/Success/ = uses correct offset and maps DTOs to domain', () async {
      when(mockDataSource.getMarketPlants(offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => [_tPlantDto]);

      final result = await repository.getMarketPlants(page: page, size: size);

      expect(result.isRight(), true);
      expect(result.getOrElse((_) => []), [_tPlantModel]);
      verify(mockDataSource.getMarketPlants(offset: 0, limit: size));
    });

    test('/Failure/ = wraps exception in RemoteSourceFailure', () async {
      when(mockDataSource.getMarketPlants(offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenThrow(Exception('network error'));

      final result = await repository.getMarketPlants(page: page, size: size);

      expect(result.isLeft(), true);
    });

    test('/Pagination/ = page 2 uses offset = size', () async {
      when(mockDataSource.getMarketPlants(offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);

      await repository.getMarketPlants(page: 2, size: size);

      verify(mockDataSource.getMarketPlants(offset: size, limit: size));
    });
  });

  group('PlantRepositoryImplementation/getUserPlants', () {
    test('/Success/ = maps DTOs to domain models', () async {
      when(mockDataSource.getUserPlants(
              userId: anyNamed('userId'), offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => [_tPlantDto]);

      final result = await repository.getUserPlants(userId: 'user-1', page: 1, size: 20);

      expect(result.isRight(), true);
      expect(result.getOrElse((_) => []), [_tPlantModel]);
    });
  });

  group('PlantRepositoryImplementation/getPlantsCreatedByUser', () {
    test('/Success/ = maps DTOs to domain models', () async {
      when(mockDataSource.getPlantsCreatedByUser(
              userId: anyNamed('userId'), offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => [_tPlantDto]);

      final result = await repository.getPlantsCreatedByUser(userId: 'user-1', page: 1, size: 20);

      expect(result.isRight(), true);
      expect(result.getOrElse((_) => []), [_tPlantModel]);
    });
  });

  group('PlantRepositoryImplementation/addPlant', () {
    test('/Success/ = calls data source with DTO JSON and returns created PlantModel', () async {
      when(mockDataSource.addPlant(plantData: anyNamed('plantData'))).thenAnswer((_) async => _tPlantDto);

      final result = await repository.addPlant(plant: _tPlantModel);

      expect(result, rightWith(_tPlantModel));
      verify(mockDataSource.addPlant(plantData: anyNamed('plantData')));
    });

    test('/Failure/ = wraps exception in RemoteSourceFailure', () async {
      when(mockDataSource.addPlant(plantData: anyNamed('plantData'))).thenThrow(Exception('server error'));

      final result = await repository.addPlant(plant: _tPlantModel);

      expect(result.isLeft(), true);
    });
  });

  group('PlantRepositoryImplementation/updatePlant', () {
    test('/Success/ = calls data source with plant id and DTO JSON', () async {
      when(mockDataSource.updatePlant(plantId: anyNamed('plantId'), plantData: anyNamed('plantData')))
          .thenAnswer((_) async {});

      final result = await repository.updatePlant(plant: _tPlantModel);

      expect(result, Right(RemoteSourceSuccess()));
      verify(mockDataSource.updatePlant(plantId: _tPlantModel.id, plantData: anyNamed('plantData')));
    });
  });

  group('PlantRepositoryImplementation/deletePlant', () {
    test('/Success/ = calls data source delete', () async {
      when(mockDataSource.deletePlant(plantId: anyNamed('plantId'))).thenAnswer((_) async {});

      final result = await repository.deletePlant(plantId: 1);

      expect(result, Right(RemoteSourceSuccess()));
    });
  });

  group('PlantRepositoryImplementation/getListOfStages', () {
    test('/Success/ = maps StageDtos to domain StageModels', () async {
      when(mockDataSource.getListOfStages(
              plantId: anyNamed('plantId'), offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => [_tStageDto]);

      final result = await repository.getListOfStages(plantId: 1, page: 1, size: 20);

      expect(result.isRight(), true);
      expect(result.getOrElse((_) => []), [_tStageModel]);
    });

    test('/Pagination/ = page 2 uses offset = size', () async {
      when(mockDataSource.getListOfStages(
              plantId: anyNamed('plantId'), offset: anyNamed('offset'), limit: anyNamed('limit')))
          .thenAnswer((_) async => []);

      await repository.getListOfStages(plantId: 1, page: 2, size: 20);

      verify(mockDataSource.getListOfStages(plantId: 1, offset: 20, limit: 20));
    });
  });

  group('PlantRepositoryImplementation/getStageInfo', () {
    test('/Success/ = maps StageDto to StageModel', () async {
      when(mockDataSource.getStageInfo(stageId: anyNamed('stageId'))).thenAnswer((_) async => _tStageDto);

      final result = await repository.getStageInfo(stageId: 1);

      expect(result, rightWith(_tStageModel));
    });

    test('/Failure/ = wraps exception in RemoteSourceFailure', () async {
      when(mockDataSource.getStageInfo(stageId: anyNamed('stageId'))).thenThrow(Exception('not found'));

      final result = await repository.getStageInfo(stageId: 1);

      expect(result.isLeft(), true);
    });
  });
}

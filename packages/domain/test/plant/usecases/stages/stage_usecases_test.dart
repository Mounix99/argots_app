import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/delete_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/update_stage_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stage_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PlantsRepository>(as: #MockPlantsRepository)])
void main() {
  late MockPlantsRepository mockPlantsRepository;
  late AddStageUseCase addStageUseCase;
  late UpdateStageUseCase updateStageUseCase;
  late DeleteStageUseCase deleteStageUseCase;

  setUp(() {
    mockPlantsRepository = MockPlantsRepository();
    addStageUseCase = AddStageUseCase(mockPlantsRepository);
    updateStageUseCase = UpdateStageUseCase(mockPlantsRepository);
    deleteStageUseCase = DeleteStageUseCase(mockPlantsRepository);
  });

  group("Domain/Plant/Add_stage", () {
    final Map<String, dynamic> tStageModel = {};

    test("/Success/ = should successfully add stage to the repository", () async {
      when(mockPlantsRepository.addStage(stageData: anyNamed("stageData")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await addStageUseCase(tStageModel);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.addStage(stageData: anyNamed("stageData")));
    });

    test("/Failure/ = should return Failure when adding stage to the repository fails", () async {
      when(mockPlantsRepository.addStage(stageData: anyNamed("stageData")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await addStageUseCase(tStageModel);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.addStage(stageData: anyNamed("stageData")));
    });
  });

  group("Domain/Plant/Update_stage", () {
    const tStageId = 1;
    final Map<String, dynamic> tStageModel = {};

    test("/Success/ = should successfully update stage with the repository request", () async {
      when(mockPlantsRepository.updateStage(stageId: anyNamed("stageId"), stageData: anyNamed("stageData")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await updateStageUseCase((tStageModel, tStageId));

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.updateStage(stageId: anyNamed("stageId"), stageData: anyNamed("stageData")));
    });

    test("/Failure/ = should return Failure when updating stage to the repository fails", () async {
      when(mockPlantsRepository.updateStage(stageId: anyNamed("stageId"), stageData: anyNamed("stageData")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await updateStageUseCase((tStageModel, tStageId));

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.updateStage(stageId: anyNamed("stageId"), stageData: anyNamed("stageData")));
    });
  });

  group("Domain/Plant/Delete_stage", () {
    const tStageId = 1;

    test("/Success/ = should successfully delete with the repository request", () async {
      when(mockPlantsRepository.deleteStage(stageId: anyNamed("stageId")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await deleteStageUseCase(tStageId);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.deleteStage(stageId: anyNamed("stageId")));
    });

    test("/Failure/ = should return Failure when deleting plant to the repository fails", () async {
      when(mockPlantsRepository.deleteStage(stageId: anyNamed("stageId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await deleteStageUseCase(tStageId);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.deleteStage(stageId: anyNamed("stageId")));
    });
  });
}

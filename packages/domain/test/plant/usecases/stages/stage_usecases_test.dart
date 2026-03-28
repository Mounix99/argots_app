import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/delete_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/update_stage_usecase.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stage_usecases_test.mocks.dart';

final _tStageModel = StageModel(
  id: 1,
  title: 'Test Stage',
  description: null,
  createdAt: DateTime(2024),
  lastUpdateAt: DateTime(2024),
  plantId: 1,
  authorId: 'author-1',
  duration: 30,
);

@GenerateNiceMocks([MockSpec<PlantsRepository>(as: #MockPlantsRepository)])
void main() {
  late MockPlantsRepository mockPlantsRepository;
  late AddStageUseCase addStageUseCase;
  late UpdateStageUseCase updateStageUseCase;
  late DeleteStageUseCase deleteStageUseCase;

  setUp(() {
    provideDummy<Either<Failure, Success>>(Right(RemoteSourceSuccess()));
    mockPlantsRepository = MockPlantsRepository();
    addStageUseCase = AddStageUseCase(mockPlantsRepository);
    updateStageUseCase = UpdateStageUseCase(mockPlantsRepository);
    deleteStageUseCase = DeleteStageUseCase(mockPlantsRepository);
  });

  group("Domain/Plant/Add_stage", () {
    test("/Success/ = should successfully add stage to the repository", () async {
      when(mockPlantsRepository.addStage(stage: anyNamed("stage")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await addStageUseCase(_tStageModel);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.addStage(stage: anyNamed("stage")));
    });

    test("/Failure/ = should return Failure when adding stage to the repository fails", () async {
      when(mockPlantsRepository.addStage(stage: anyNamed("stage")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await addStageUseCase(_tStageModel);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.addStage(stage: anyNamed("stage")));
    });
  });

  group("Domain/Plant/Update_stage", () {
    test("/Success/ = should successfully update stage with the repository request", () async {
      when(mockPlantsRepository.updateStage(stage: anyNamed("stage")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await updateStageUseCase(_tStageModel);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.updateStage(stage: anyNamed("stage")));
    });

    test("/Failure/ = should return Failure when updating stage to the repository fails", () async {
      when(mockPlantsRepository.updateStage(stage: anyNamed("stage")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await updateStageUseCase(_tStageModel);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.updateStage(stage: anyNamed("stage")));
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

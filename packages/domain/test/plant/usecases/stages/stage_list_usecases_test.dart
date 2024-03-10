import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stage_list_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PlantsRepository>(as: #MockPlantsRepository)])
void main() {
  late MockPlantsRepository mockPlantsRepository;
  late GetListOfStagesUsecase getListOfStagesUsecase;

  setUp(() {
    mockPlantsRepository = MockPlantsRepository();
    getListOfStagesUsecase = GetListOfStagesUsecase(mockPlantsRepository);
  });

  group("Domain/Plant/Get_list_of_stages", () {
    const List<StageModel> tStageModelList = [];
    const tPlantId = 1;

    test("/Success/ = should get list of stages from the repository", () async {
      when(mockPlantsRepository.getListOfStages(plantId: anyNamed("plantId")))
          .thenAnswer((_) async => const Right(tStageModelList));

      final result = await getListOfStagesUsecase(tPlantId);

      expect(result, const Right(tStageModelList));

      verify(mockPlantsRepository.getListOfStages(plantId: anyNamed("plantId")));
    });

    test("/Failure/ = should return Failure when getting list of stages from the repository fails", () async {
      when(mockPlantsRepository.getListOfStages(plantId: anyNamed("plantId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getListOfStagesUsecase(tPlantId);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.getListOfStages(plantId: anyNamed("plantId")));
    });
  });
}

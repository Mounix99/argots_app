import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/plant_usecases/get_market_plants_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plants_created_by_me_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_user_plants_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'plant_lists_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PlantsRepository>(as: #MockPlantsRepository)])
void main() {
  late MockPlantsRepository mockPlantsRepository;
  late GetMarketPlantsUsecase getMarketPlantsUsecase;
  late GetPlantsCreatedByMeUsecase getListOfMyPlantsUsecase;
  late GetUserPlantsUsecase getUserPlatsUsecase;

  setUp(() {
    mockPlantsRepository = MockPlantsRepository();
    getMarketPlantsUsecase = GetMarketPlantsUsecase(mockPlantsRepository);
    getListOfMyPlantsUsecase = GetPlantsCreatedByMeUsecase(mockPlantsRepository);
    getUserPlatsUsecase = GetUserPlantsUsecase(mockPlantsRepository);
  });

  group("Domain/Plant/Get_market_plants", () {
    const List<PlantModel> tPlantModelList = [];

    test("/Success/ = should get list of plants from other users from the repository", () async {
      when(mockPlantsRepository.getMarketPlants()).thenAnswer((_) async => const Right(tPlantModelList));

      final result = await getMarketPlantsUsecase();

      expect(result, const Right(tPlantModelList));

      verify(mockPlantsRepository.getMarketPlants());
    });

    test("/Failure/ = should return Failure when getting list of plants from other users from the repository fails",
        () async {
      when(mockPlantsRepository.getMarketPlants()).thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getMarketPlantsUsecase();

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.getMarketPlants());
    });
  });

  group("Domain/Plant/Get_plants_created_by_user", () {
    const List<PlantModel> tPlantModelList = [];

    test("/Success/ = should get list of plants created by user from the repository", () async {
      when(mockPlantsRepository.getPlantsCreatedByUser(userId: anyNamed("userId")))
          .thenAnswer((_) async => const Right(tPlantModelList));

      final result = await getListOfMyPlantsUsecase("");

      expect(result, const Right(tPlantModelList));

      verify(mockPlantsRepository.getPlantsCreatedByUser(userId: anyNamed("userId")));
    });

    test("/Failure/ = should return Failure when getting list of plants created by user from the repository fails",
        () async {
      when(mockPlantsRepository.getPlantsCreatedByUser(userId: anyNamed("userId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getListOfMyPlantsUsecase("");

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.getPlantsCreatedByUser(userId: anyNamed("userId")));
    });
  });

  group("Domain/Plant/Get_user_plants", () {
    const List<PlantModel> tPlantModelList = [];

    test("/Success/ = should get my plants from the repository", () async {
      when(mockPlantsRepository.getUserPlants(userId: anyNamed("userId")))
          .thenAnswer((_) async => const Right(tPlantModelList));

      final result = await getUserPlatsUsecase("");

      expect(result, const Right(tPlantModelList));

      verify(mockPlantsRepository.getUserPlants(userId: anyNamed("userId")));
    });

    test("/Failure/ = should return Failure when getting my plants from the repository fails", () async {
      when(mockPlantsRepository.getUserPlants(userId: anyNamed("userId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getUserPlatsUsecase("");

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.getUserPlants(userId: anyNamed("userId")));
    });
  });
}

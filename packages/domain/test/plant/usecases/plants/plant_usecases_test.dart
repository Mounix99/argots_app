import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/delete_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/update_plant_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'plant_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PlantsRepository>(as: #MockPlantsRepository), MockSpec<PlantModel>(as: #MockPlantModel)])
void main() {
  late MockPlantsRepository mockPlantsRepository;
  late AddPlantUseCase addPlantUseCase;
  late UpdatePlantUseCase updatePlantUseCase;
  late DeletePlantUseCase deletePlantUseCase;
  late GetPlantInfoUseCase getPlantInfoUseCase;
  late AddPlantToUserUseCase addPlantToUserUseCase;

  setUp(() {
    mockPlantsRepository = MockPlantsRepository();
    addPlantUseCase = AddPlantUseCase(mockPlantsRepository);
    updatePlantUseCase = UpdatePlantUseCase(mockPlantsRepository);
    deletePlantUseCase = DeletePlantUseCase(mockPlantsRepository);
    getPlantInfoUseCase = GetPlantInfoUseCase(mockPlantsRepository);
    addPlantToUserUseCase = AddPlantToUserUseCase(mockPlantsRepository);
  });

  group("Domain/Plant/Add_plant", () {
    final Map<String, dynamic> tPlantModel = {};

    test("/Success/ = should add plant to the repository", () async {
      when(mockPlantsRepository.addPlant(plantData: anyNamed("plantData")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await addPlantUseCase(tPlantModel);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.addPlant(plantData: anyNamed("plantData")));
    });

    test("/Failure/ = should return Failure when adding plant to the repository fails", () async {
      when(mockPlantsRepository.addPlant(plantData: anyNamed("plantData")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await addPlantUseCase(tPlantModel);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.addPlant(plantData: anyNamed("plantData")));
    });
  });

  group("Domain/Plant/Update_plant", () {
    const tPlantId = 1;
    final Map<String, dynamic> tPlantModel = {};

    test("/Success/ = should update plant to the repository", () async {
      when(mockPlantsRepository.updatePlant(plantData: tPlantModel, plantId: anyNamed("plantId")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await updatePlantUseCase((tPlantModel, tPlantId));

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.updatePlant(plantData: tPlantModel, plantId: anyNamed("plantId")));
    });

    test("/Failure/ = should return Failure when updating plant to the repository fails", () async {
      when(mockPlantsRepository.updatePlant(plantData: tPlantModel, plantId: anyNamed("plantId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await updatePlantUseCase((tPlantModel, tPlantId));

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.updatePlant(plantData: tPlantModel, plantId: anyNamed("plantId")));
    });
  });

  group("Domain/Plant/Delete_plant", () {
    const tPlantId = 1;

    test("/Success/ = should delete plant to the repository", () async {
      when(mockPlantsRepository.deletePlant(plantId: anyNamed("plantId")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await deletePlantUseCase(tPlantId);

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.deletePlant(plantId: anyNamed("plantId")));
    });

    test("/Failure/ = should return Failure when deleting plant to the repository fails", () async {
      when(mockPlantsRepository.deletePlant(plantId: anyNamed("plantId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await deletePlantUseCase(tPlantId);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.deletePlant(plantId: anyNamed("plantId")));
    });
  });

  group("Domain/Plant/Get_plant_info", () {
    const tPlantId = 1;
    final tPlantModel = MockPlantModel();

    test("/Success/ = should get plant info from the repository", () async {
      when(mockPlantsRepository.getPlantInfo(plantId: anyNamed("plantId"))).thenAnswer((_) async => Right(tPlantModel));

      final result = await getPlantInfoUseCase(tPlantId);

      expect(result, Right(tPlantModel));

      verify(mockPlantsRepository.getPlantInfo(plantId: anyNamed("plantId")));
    });

    test("/Failure/ = should return Failure when getting plant info from the repository fails", () async {
      when(mockPlantsRepository.getPlantInfo(plantId: anyNamed("plantId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await getPlantInfoUseCase(tPlantId);

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.getPlantInfo(plantId: anyNamed("plantId")));
    });
  });

  group("Domain/Plant/Add_plant_to_user", () {
    const tPlantId = 1;
    const tUserId = "1";

    test("/Success/ = should add plant to user in the repository", () async {
      when(mockPlantsRepository.addPlantToUser(plantId: anyNamed("plantId"), userId: anyNamed("userId")))
          .thenAnswer((_) async => Right(RemoteSourceSuccess()));

      final result = await addPlantToUserUseCase((plantId: tPlantId, userId: tUserId));

      expect(result, Right(RemoteSourceSuccess()));

      verify(mockPlantsRepository.addPlantToUser(plantId: anyNamed("plantId"), userId: anyNamed("userId")));
    });

    test("/Failure/ = should return Failure when adding plant to user in the repository fails", () async {
      when(mockPlantsRepository.addPlantToUser(plantId: anyNamed("plantId"), userId: anyNamed("userId")))
          .thenAnswer((_) async => const Left(RemoteSourceFailure()));

      final result = await addPlantToUserUseCase((plantId: tPlantId, userId: tUserId));

      expect(result, const Left(RemoteSourceFailure()));

      verify(mockPlantsRepository.addPlantToUser(plantId: anyNamed("plantId"), userId: anyNamed("userId")));
    });
  });
}

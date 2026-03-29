import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/plants/entities/plant_model.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class AddPlantUseCase implements UseCase<PlantModel, PlantModel> {
  final PlantsRepository _plantsRepository;

  AddPlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, PlantModel>> call(PlantModel params) async {
    return await _plantsRepository.addPlant(plant: params);
  }
}

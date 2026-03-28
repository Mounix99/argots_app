import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/plants/entities/plant_model.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class UpdatePlantUseCase implements UseCase<Success, PlantModel> {
  final PlantsRepository _plantsRepository;

  UpdatePlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(PlantModel params) async {
    return await _plantsRepository.updatePlant(plant: params);
  }
}

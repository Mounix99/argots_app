import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetPlantInfoUseCase implements UseCase<PlantModel, int> {
  final PlantsRepository _plantsRepository;

  GetPlantInfoUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, PlantModel>> call(int plantId) async {
    return await _plantsRepository.getPlantInfo(plantId: plantId);
  }
}

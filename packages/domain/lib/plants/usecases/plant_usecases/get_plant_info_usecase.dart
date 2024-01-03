import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetPlantInfoUseCase implements Usecase<PlantModel, int> {
  final PlantsRepository _plantsRepository;

  GetPlantInfoUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, PlantModel>> call(int plantId) async {
    return await _plantsRepository.getPlantInfo(plantId: plantId);
  }
}

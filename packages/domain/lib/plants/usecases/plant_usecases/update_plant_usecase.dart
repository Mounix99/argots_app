import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class UpdatePlantUseCase implements Usecase<Success, (Map<String, dynamic>, int)> {
  final PlantsRepository _plantsRepository;

  UpdatePlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call((Map<String, dynamic>, int) params) async {
    return await _plantsRepository.updatePlant(plantData: params.$1, plantId: params.$2);
  }
}

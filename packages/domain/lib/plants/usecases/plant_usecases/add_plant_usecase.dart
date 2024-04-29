import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class AddPlantUseCase implements Usecase<int, Map<String, dynamic>> {
  final PlantsRepository _plantsRepository;

  AddPlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, int>> call(Map<String, dynamic> params) async {
    return await _plantsRepository.addPlant(plantData: params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class AddPlantUseCase implements Usecase<Success, Map<String, dynamic>> {
  final PlantsRepository _plantsRepository;

  AddPlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(Map<String, dynamic> params) async {
    return await _plantsRepository.addPlant(plantData: params);
  }
}

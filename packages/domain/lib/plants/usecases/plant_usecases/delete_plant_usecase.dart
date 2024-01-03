import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';

import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class DeletePlantUseCase implements Usecase<Success, int> {
  final PlantsRepository _plantsRepository;

  DeletePlantUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(int id) async {
    return await _plantsRepository.deletePlant(plantId: id);
  }
}

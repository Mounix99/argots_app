import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';

import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetUserPlantsUsecase implements Usecase<List<PlantModel>, String> {
  final PlantsRepository _plantsRepository;

  GetUserPlantsUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(String id) async {
    return await _plantsRepository.getUserPlants(userId: id);
  }
}

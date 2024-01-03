import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';

import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetMarketPlantsUsecase implements UsecaseNoParam<List<PlantModel>> {
  final PlantsRepository _plantsRepository;

  GetMarketPlantsUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call() async {
    return await _plantsRepository.getMarketPlants();
  }
}

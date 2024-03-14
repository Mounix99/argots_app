import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetPlantsCreatedByMeUsecase implements Usecase<List<PlantModel>, String> {
  final PlantsRepository _plantsRepository;

  GetPlantsCreatedByMeUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(String id) async {
    return _plantsRepository.getPlantsCreatedByUser(userId: id);
  }
}

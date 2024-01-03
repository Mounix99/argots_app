import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

class GetPlantsCreatedByMeUsecase implements Usecase<List<PlantModel>, List<int>?> {
  final PlantsRepository _plantsRepository;

  GetPlantsCreatedByMeUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(List<int>? ids) async {
    return _plantsRepository.getPlantsCreatedByMe(plantIds: ids);
  }
}

import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

typedef GetPlantsCreatedByMeParams = ({String id, int page});

class GetPlantsCreatedByMeUsecase implements Usecase<List<PlantModel>, GetPlantsCreatedByMeParams> {
  final PlantsRepository _plantsRepository;

  GetPlantsCreatedByMeUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(GetPlantsCreatedByMeParams params) {
    return _plantsRepository.getPlantsCreatedByUser(userId: params.id, page: params.page);
  }
}

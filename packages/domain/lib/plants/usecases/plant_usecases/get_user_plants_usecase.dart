import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';

import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

typedef GetUserPlantsParams = ({String id, int page, int size});

class GetUserPlantsUsecase implements Usecase<List<PlantModel>, GetUserPlantsParams> {
  final PlantsRepository _plantsRepository;

  GetUserPlantsUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(GetUserPlantsParams params) async {
    return await _plantsRepository.getUserPlants(userId: params.id, page: params.page, size: params.size);
  }
}

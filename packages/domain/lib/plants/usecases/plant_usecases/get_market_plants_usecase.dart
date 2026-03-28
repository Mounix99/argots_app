import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';

import '../../../core/usecase_contract.dart';
import '../../entities/plant_model.dart';
import '../../repositories/plant_repository.dart';

typedef GetMarketPlantsParams = ({int page, int size});

class GetMarketPlantsUseCase implements UseCase<List<PlantModel>, GetMarketPlantsParams> {
  final PlantsRepository _plantsRepository;

  GetMarketPlantsUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, List<PlantModel>>> call(GetMarketPlantsParams params) async {
    return await _plantsRepository.getMarketPlants(page: params.page, size: params.size);
  }
}

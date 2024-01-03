import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/stage_model.dart';
import '../../repositories/plant_repository.dart';

class GetListOfStagesUsecase implements Usecase<List<StageModel>, int> {
  final PlantsRepository _plantsRepository;

  GetListOfStagesUsecase(this._plantsRepository);

  @override
  Future<Either<Failure, List<StageModel>>> call(int plantId) async {
    return await _plantsRepository.getListOfStages(plantId: plantId);
  }
}

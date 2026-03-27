import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/stage_model.dart';
import '../../repositories/plant_repository.dart';

class GetStageInfoUseCase implements Usecase<StageModel, int> {
  final PlantsRepository _plantsRepository;

  GetStageInfoUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, StageModel>> call(int stageId) async {
    return await _plantsRepository.getStageInfo(stageId: stageId);
  }
}

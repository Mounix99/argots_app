import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../entities/stage_model.dart';
import '../../repositories/plant_repository.dart';

typedef GetListOfStagesParams = ({int plantId, int page, int size});

class GetListOfStagesUseCase implements UseCase<List<StageModel>, GetListOfStagesParams> {
  final PlantsRepository _plantsRepository;

  GetListOfStagesUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, List<StageModel>>> call(GetListOfStagesParams params) async {
    return await _plantsRepository.getListOfStages(plantId: params.plantId, page: params.page, size: params.size);
  }
}

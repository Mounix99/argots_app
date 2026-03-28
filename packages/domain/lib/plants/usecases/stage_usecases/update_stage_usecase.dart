import 'package:fpdart/fpdart.dart';
import 'package:domain/plants/entities/stage_model.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class UpdateStageUseCase implements UseCase<Success, StageModel> {
  final PlantsRepository _plantsRepository;

  UpdateStageUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(StageModel params) async {
    return await _plantsRepository.updateStage(stage: params);
  }
}

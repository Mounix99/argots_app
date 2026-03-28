import 'package:fpdart/fpdart.dart';
import 'package:domain/plants/entities/stage_model.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class AddStageUseCase implements UseCase<Success, StageModel> {
  final PlantsRepository _plantsRepository;

  AddStageUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(StageModel params) async {
    return await _plantsRepository.addStage(stage: params);
  }
}

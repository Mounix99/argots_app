import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class DeleteStageUseCase implements Usecase<Success, int> {
  final PlantsRepository _plantsRepository;

  DeleteStageUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(int stageId) async {
    return await _plantsRepository.deleteStage(stageId: stageId);
  }
}

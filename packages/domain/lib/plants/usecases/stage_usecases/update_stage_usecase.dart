import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class UpdateStageUseCase implements Usecase<Success, (Map<String, dynamic>, int)> {
  final PlantsRepository _plantsRepository;

  UpdateStageUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call((Map<String, dynamic>, int) params) async {
    return await _plantsRepository.updateStage(stageId: params.$2, stageData: params.$1);
  }
}

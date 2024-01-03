import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/success_objects/success_object.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/plant_repository.dart';

class AddStageUseCase implements Usecase<Success, Map<String, dynamic>> {
  final PlantsRepository _plantsRepository;

  AddStageUseCase(this._plantsRepository);

  @override
  Future<Either<Failure, Success>> call(Map<String, dynamic> params) async {
    return await _plantsRepository.addStage(stageData: params);
  }
}

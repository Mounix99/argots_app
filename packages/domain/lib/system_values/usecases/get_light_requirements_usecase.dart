import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/usecase_contract.dart';
import '../entities/light_requirement.dart';
import '../repositories/system_values_repository.dart';

class GetLightRequirementsUseCase implements UseCaseNoParam<List<LightRequirement>> {
  final SystemValuesRepository _repository;

  GetLightRequirementsUseCase(this._repository);

  @override
  Future<Either<Failure, List<LightRequirement>>> call() => _repository.getLightRequirements();
}

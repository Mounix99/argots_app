import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/usecase_contract.dart';
import '../entities/plant_type.dart';
import '../repositories/system_values_repository.dart';

class GetPlantTypesUseCase implements UseCaseNoParam<List<PlantType>> {
  final SystemValuesRepository _repository;

  GetPlantTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<PlantType>>> call() => _repository.getPlantTypes();
}

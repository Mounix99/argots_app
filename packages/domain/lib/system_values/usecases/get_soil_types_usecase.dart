import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/usecase_contract.dart';
import '../entities/soil_type.dart';
import '../repositories/system_values_repository.dart';

class GetSoilTypesUseCase implements UseCaseNoParam<List<SoilType>> {
  final SystemValuesRepository _repository;

  GetSoilTypesUseCase(this._repository);

  @override
  Future<Either<Failure, List<SoilType>>> call() => _repository.getSoilTypes();
}

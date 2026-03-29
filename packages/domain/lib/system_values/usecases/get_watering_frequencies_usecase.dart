import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/usecase_contract.dart';
import '../entities/watering_frequency.dart';
import '../repositories/system_values_repository.dart';

class GetWateringFrequenciesUseCase implements UseCaseNoParam<List<WateringFrequency>> {
  final SystemValuesRepository _repository;

  GetWateringFrequenciesUseCase(this._repository);

  @override
  Future<Either<Failure, List<WateringFrequency>>> call() => _repository.getWateringFrequencies();
}

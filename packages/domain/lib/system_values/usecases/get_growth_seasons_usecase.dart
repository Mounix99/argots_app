import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../../core/usecase_contract.dart';
import '../entities/growth_season.dart';
import '../repositories/system_values_repository.dart';

class GetGrowthSeasonsUseCase implements UseCaseNoParam<List<GrowthSeason>> {
  final SystemValuesRepository _repository;

  GetGrowthSeasonsUseCase(this._repository);

  @override
  Future<Either<Failure, List<GrowthSeason>>> call() => _repository.getGrowthSeasons();
}

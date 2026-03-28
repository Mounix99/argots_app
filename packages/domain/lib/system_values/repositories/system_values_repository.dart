import 'package:fpdart/fpdart.dart';

import '../../core/errors/failure.dart';
import '../entities/growth_season.dart';
import '../entities/light_requirement.dart';
import '../entities/plant_type.dart';
import '../entities/soil_type.dart';
import '../entities/watering_frequency.dart';

abstract class SystemValuesRepository {
  Future<Either<Failure, List<SoilType>>> getSoilTypes();

  Future<Either<Failure, List<PlantType>>> getPlantTypes();

  Future<Either<Failure, List<LightRequirement>>> getLightRequirements();

  Future<Either<Failure, List<WateringFrequency>>> getWateringFrequencies();

  Future<Either<Failure, List<GrowthSeason>>> getGrowthSeasons();
}

import '../dto/growth_season_dto.dart';
import '../dto/light_requirement_dto.dart';
import '../dto/plant_type_dto.dart';
import '../dto/soil_type_dto.dart';
import '../dto/watering_frequency_dto.dart';

abstract class SystemValuesRemoteDataSource {
  Future<List<SoilTypeDto>> getSoilTypes();

  Future<List<PlantTypeDto>> getPlantTypes();

  Future<List<LightRequirementDto>> getLightRequirements();

  Future<List<WateringFrequencyDto>> getWateringFrequencies();

  Future<List<GrowthSeasonDto>> getGrowthSeasons();
}

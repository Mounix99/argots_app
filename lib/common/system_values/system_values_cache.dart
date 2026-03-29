import 'package:domain/system_values/entities/growth_season.dart';
import 'package:domain/system_values/entities/light_requirement.dart';
import 'package:domain/system_values/entities/plant_type.dart';
import 'package:domain/system_values/entities/soil_type.dart';
import 'package:domain/system_values/entities/watering_frequency.dart';
import 'package:domain/system_values/usecases/get_growth_seasons_usecase.dart';
import 'package:domain/system_values/usecases/get_light_requirements_usecase.dart';
import 'package:domain/system_values/usecases/get_plant_types_usecase.dart';
import 'package:domain/system_values/usecases/get_soil_types_usecase.dart';
import 'package:domain/system_values/usecases/get_watering_frequencies_usecase.dart';

/// In-memory cache for system value lookup tables.
///
/// Each type is fetched from Supabase on first access and held for the
/// lifetime of the app session. Call [invalidate] (optionally scoped by key)
/// to force a refresh on the next access.
class SystemValuesCache {
  final GetSoilTypesUseCase _getSoilTypes;
  final GetPlantTypesUseCase _getPlantTypes;
  final GetLightRequirementsUseCase _getLightRequirements;
  final GetWateringFrequenciesUseCase _getWateringFrequencies;
  final GetGrowthSeasonsUseCase _getGrowthSeasons;

  SystemValuesCache({
    required GetSoilTypesUseCase getSoilTypes,
    required GetPlantTypesUseCase getPlantTypes,
    required GetLightRequirementsUseCase getLightRequirements,
    required GetWateringFrequenciesUseCase getWateringFrequencies,
    required GetGrowthSeasonsUseCase getGrowthSeasons,
  })  : _getSoilTypes = getSoilTypes,
        _getPlantTypes = getPlantTypes,
        _getLightRequirements = getLightRequirements,
        _getWateringFrequencies = getWateringFrequencies,
        _getGrowthSeasons = getGrowthSeasons;

  List<SoilType>? _soilTypes;
  List<PlantType>? _plantTypes;
  List<LightRequirement>? _lightRequirements;
  List<WateringFrequency>? _wateringFrequencies;
  List<GrowthSeason>? _growthSeasons;

  Future<List<SoilType>> getSoilTypes() async {
    if (_soilTypes != null) return _soilTypes!;
    final result = await _getSoilTypes();
    return result.fold((_) => [], (values) => _soilTypes = values);
  }

  Future<List<PlantType>> getPlantTypes() async {
    if (_plantTypes != null) return _plantTypes!;
    final result = await _getPlantTypes();
    return result.fold((_) => [], (values) => _plantTypes = values);
  }

  Future<List<LightRequirement>> getLightRequirements() async {
    if (_lightRequirements != null) return _lightRequirements!;
    final result = await _getLightRequirements();
    return result.fold((_) => [], (values) => _lightRequirements = values);
  }

  Future<List<WateringFrequency>> getWateringFrequencies() async {
    if (_wateringFrequencies != null) return _wateringFrequencies!;
    final result = await _getWateringFrequencies();
    return result.fold((_) => [], (values) => _wateringFrequencies = values);
  }

  Future<List<GrowthSeason>> getGrowthSeasons() async {
    if (_growthSeasons != null) return _growthSeasons!;
    final result = await _getGrowthSeasons();
    return result.fold((_) => [], (values) => _growthSeasons = values);
  }

  /// Invalidates the cached value for a given key, or all keys if null.
  void invalidate([SystemValuesCacheKey? key]) {
    if (key == null) {
      _soilTypes = null;
      _plantTypes = null;
      _lightRequirements = null;
      _wateringFrequencies = null;
      _growthSeasons = null;
      return;
    }
    switch (key) {
      case SystemValuesCacheKey.soilTypes:
        _soilTypes = null;
      case SystemValuesCacheKey.plantTypes:
        _plantTypes = null;
      case SystemValuesCacheKey.lightRequirements:
        _lightRequirements = null;
      case SystemValuesCacheKey.wateringFrequencies:
        _wateringFrequencies = null;
      case SystemValuesCacheKey.growthSeasons:
        _growthSeasons = null;
    }
  }
}

enum SystemValuesCacheKey { soilTypes, plantTypes, lightRequirements, wateringFrequencies, growthSeasons }

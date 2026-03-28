import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/growth_season_dto.dart';
import '../dto/light_requirement_dto.dart';
import '../dto/plant_type_dto.dart';
import '../dto/soil_type_dto.dart';
import '../dto/watering_frequency_dto.dart';
import 'system_values_remote_data_source.dart';

class SystemValuesRemoteDataSourceImpl implements SystemValuesRemoteDataSource {
  static const String _soilTypesTable = 'soil_types';
  static const String _plantTypesTable = 'plant_types';
  static const String _lightRequirementsTable = 'light_requirements';
  static const String _wateringFrequenciesTable = 'watering_frequencies';
  static const String _growthSeasonsTable = 'growth_seasons';

  final Supabase supabase;

  SystemValuesRemoteDataSourceImpl({required this.supabase});

  @override
  Future<List<SoilTypeDto>> getSoilTypes() async {
    final response = await supabase.client
        .from(_soilTypesTable)
        .select()
        .order('sort_order');
    return response.map((e) => SoilTypeDto.fromJson(e)).toList();
  }

  @override
  Future<List<PlantTypeDto>> getPlantTypes() async {
    final response = await supabase.client
        .from(_plantTypesTable)
        .select()
        .order('sort_order');
    return response.map((e) => PlantTypeDto.fromJson(e)).toList();
  }

  @override
  Future<List<LightRequirementDto>> getLightRequirements() async {
    final response = await supabase.client
        .from(_lightRequirementsTable)
        .select()
        .order('sort_order');
    return response.map((e) => LightRequirementDto.fromJson(e)).toList();
  }

  @override
  Future<List<WateringFrequencyDto>> getWateringFrequencies() async {
    final response = await supabase.client
        .from(_wateringFrequenciesTable)
        .select()
        .order('sort_order');
    return response.map((e) => WateringFrequencyDto.fromJson(e)).toList();
  }

  @override
  Future<List<GrowthSeasonDto>> getGrowthSeasons() async {
    final response = await supabase.client
        .from(_growthSeasonsTable)
        .select()
        .order('sort_order');
    return response.map((e) => GrowthSeasonDto.fromJson(e)).toList();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../dto/plant_dto.dart';
import '../dto/stage_dto.dart';
import 'plant_remote_data_source.dart';

class PlantRemoteDataSourceImpl implements PlantRemoteDataSource {
  static const String _plantTable = 'plants';
  static const String _stageTable = 'stages';

  final Supabase supabase;

  PlantRemoteDataSourceImpl({required this.supabase});

  /// Plants

  @override
  Future<PlantDto> getPlantInfo({required int plantId}) async {
    final response = await supabase.client.from(_plantTable).select().eq('id', plantId);
    if (response.length > 1) {
      throw Exception('More than one plant with the same id');
    } else if (response.isNotEmpty) {
      return PlantDto.fromJson(response.first);
    } else {
      throw Exception('No plant with the given id');
    }
  }

  @override
  Future<void> addPlant({required Map<String, dynamic> plantData}) async {
    await supabase.client.from(_plantTable).insert(plantData);
  }

  @override
  Future<void> updatePlant({required int plantId, required Map<String, dynamic> plantData}) async {
    await supabase.client.from(_plantTable).update(plantData).eq('id', plantId);
  }

  @override
  Future<void> deletePlant({required int plantId}) async {
    await supabase.client.from(_plantTable).delete().eq('id', plantId);
  }

  @override
  Future<List<PlantDto>> getMarketPlants({required int offset, required int limit}) async {
    final response = await supabase.client.from(_plantTable).select().eq('public', true).range(offset, offset + limit - 1);
    return response.map((e) => PlantDto.fromJson(e)).toList();
  }

  @override
  Future<List<PlantDto>> getPlantsCreatedByUser({required String userId, required int offset, required int limit}) async {
    final response = await supabase.client.from(_plantTable).select().eq('author_id', userId).range(offset, offset + limit - 1);
    return response.map((e) => PlantDto.fromJson(e)).toList();
  }

  @override
  Future<List<PlantDto>> getUserPlants({required String userId, required int offset, required int limit}) async {
    final response = await supabase.client.from(_plantTable).select().eq('used_by', '{$userId}').range(offset, offset + limit - 1);
    return response.map((e) => PlantDto.fromJson(e)).toList();
  }

  /// Stages

  @override
  Future<void> addStage({required Map<String, dynamic> stageData}) async {
    await supabase.client.from(_stageTable).insert(stageData);
  }

  @override
  Future<void> updateStage({required int stageId, required Map<String, dynamic> stageData}) async {
    await supabase.client.from(_stageTable).update(stageData).eq('id', stageId);
  }

  @override
  Future<void> deleteStage({required int stageId}) async {
    await supabase.client.from(_stageTable).delete().eq('id', stageId);
  }

  @override
  Future<List<StageDto>> getListOfStages({required int plantId, required int offset, required int limit}) async {
    final response = await supabase.client.from(_stageTable).select().eq('plant_id', plantId).range(offset, offset + limit - 1);
    return response.map((e) => StageDto.fromJson(e)).toList();
  }

  @override
  Future<StageDto> getStageInfo({required int stageId}) async {
    final response = await supabase.client.from(_stageTable).select().eq('id', stageId);
    if (response.length > 1) {
      throw Exception('More than one stage with the same id');
    } else if (response.isNotEmpty) {
      return StageDto.fromJson(response.first);
    } else {
      throw Exception('No stage with the given id');
    }
  }
}

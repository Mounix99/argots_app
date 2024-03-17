import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final int plantId;
  final PlantsRepository _plantsRepository;

  PlantDetailsCubit(this._plantsRepository, {required this.plantId}) : super(PlantDetailsState.initial()) {
    getPlantDetails();
  }

  Future<PlantModel?> getPlantDetails() async {
    emit(state.copyWith(plantDetailsRequestState: RequestState.loading));
    final result = await _plantsRepository.getPlantInfo(plantId: plantId);
    emit(result.fold(
      (failure) => state.copyWith(plantDetailsRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(plantDetailsRequestState: RequestState.success, plant: data),
    ));
    return state.plant;
  }

  Future<List<StageModel>> getStages([int page = 1, int size = 20]) async {
    emit(state.copyWith(stagesRequestState: RequestState.loading));
    final result = await _plantsRepository.getListOfStages(plantId: plantId, page: page, size: size);
    emit(result.fold(
      (failure) => state.copyWith(stagesRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(stagesRequestState: RequestState.success, stages: data),
    ));
    return state.stages!;
  }
}

class PlantDetailsState extends Equatable {
  final RequestState plantDetailsRequestState;
  final RequestState stagesRequestState;
  final String? errorMessage;
  final PlantModel? plant;
  final List<StageModel>? stages;

  const PlantDetailsState({
    required this.plantDetailsRequestState,
    required this.stagesRequestState,
    this.errorMessage,
    this.plant,
    this.stages,
  });

  PlantDetailsState copyWith({
    RequestState? plantDetailsRequestState,
    RequestState? stagesRequestState,
    String? errorMessage,
    PlantModel? plant,
    List<StageModel>? stages,
  }) {
    return PlantDetailsState(
      plantDetailsRequestState: plantDetailsRequestState ?? this.plantDetailsRequestState,
      stagesRequestState: stagesRequestState ?? this.stagesRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      plant: plant ?? this.plant,
      stages: stages ?? this.stages,
    );
  }

  factory PlantDetailsState.initial() {
    return const PlantDetailsState(
      plantDetailsRequestState: RequestState.initial,
      stagesRequestState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [plantDetailsRequestState, stagesRequestState, errorMessage, plant, stages];
}

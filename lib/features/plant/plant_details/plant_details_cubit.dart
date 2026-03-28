import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_management/base/request_state.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final int plantId;
  final GetPlantInfoUseCase _getPlantInfoUseCase;
  final GetListOfStagesUseCase _getListOfStagesUseCase;

  PlantDetailsCubit(
    this._getPlantInfoUseCase,
    this._getListOfStagesUseCase, {
    required this.plantId,
  }) : super(PlantDetailsState.initial()) {
    getPlantDetails();
  }

  Future<PlantModel?> getPlantDetails() async {
    emit(state.copyWith(plantDetailsRequestState: RequestState.loading));
    final result = await _getPlantInfoUseCase(plantId);
    emit(result.match(
      (failure) => state.copyWith(plantDetailsRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(plantDetailsRequestState: RequestState.success, plant: data),
    ));
    return state.plant;
  }

  Future<List<StageModel>> getStages([int page = 1, int size = 20]) async {
    emit(state.copyWith(stagesRequestState: RequestState.loading));
    final result = await _getListOfStagesUseCase((plantId: plantId, page: page, size: size));
    emit(result.match(
      (failure) => state.copyWith(stagesRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(stagesRequestState: RequestState.success, stages: data),
    ));
    return state.stages ?? [];
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

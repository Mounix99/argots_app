import 'dart:async';

import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/delete_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plant_info_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_management/base/request_state.dart';

class PlantDetailsCubit extends Cubit<PlantDetailsState> {
  final int plantId;
  final String currentUserId;
  final GetPlantInfoUseCase _getPlantInfoUseCase;
  final GetListOfStagesUseCase _getListOfStagesUseCase;
  final DeletePlantUseCase _deletePlantUseCase;
  final RemovePlantFromUserUseCase _removePlantFromUserUseCase;
  final AppEventBus _appEventBus;
  late final StreamSubscription<AppEvent> _eventSubscription;

  PlantDetailsCubit(
    this._getPlantInfoUseCase,
    this._getListOfStagesUseCase,
    this._deletePlantUseCase,
    this._removePlantFromUserUseCase,
    this._appEventBus, {
    required this.plantId,
    required this.currentUserId,
  }) : super(PlantDetailsState.initial()) {
    _eventSubscription = _appEventBus.stream.listen((event) {
      if (event == AppEvent.plantsUpdated) refresh();
    });
    getPlantDetails();
  }

  Future<void> getPlantDetails() async {
    emit(state.copyWith(plantDetailsRequestState: RequestState.loading));
    final result = await _getPlantInfoUseCase(plantId);
    result.match(
      (failure) => emit(state.copyWith(
          plantDetailsRequestState: RequestState.error,
          errorMessage: failure.error.toString())),
      (data) {
        emit(state.copyWith(
          plantDetailsRequestState: RequestState.success,
          plant: data,
          isAuthor: data.authorId == currentUserId,
          isInUsedBy: data.usedBy?.contains(currentUserId) ?? false,
        ));
        getStages();
      },
    );
  }

  Future<void> getStages([int page = 1, int size = 20]) async {
    emit(state.copyWith(stagesRequestState: RequestState.loading));
    final result = await _getListOfStagesUseCase((plantId: plantId, page: page, size: size));
    emit(result.match(
      (failure) => state.copyWith(stagesRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(stagesRequestState: RequestState.success, stages: data),
    ));
  }

  Future<void> deletePlant() async {
    emit(state.copyWith(deleteRequestState: RequestState.loading));
    final result = await _deletePlantUseCase(plantId);
    result.match(
      (failure) => emit(state.copyWith(
          deleteRequestState: RequestState.error,
          errorMessage: failure.error.toString())),
      (_) {
        _appEventBus.fire(AppEvent.plantsUpdated);
        emit(state.copyWith(deleteRequestState: RequestState.success));
      },
    );
  }

  Future<void> removePlantFromUser() async {
    emit(state.copyWith(deleteRequestState: RequestState.loading));
    final result = await _removePlantFromUserUseCase((plantId: plantId, userId: currentUserId));
    result.match(
      (failure) => emit(state.copyWith(
          deleteRequestState: RequestState.error,
          errorMessage: failure.error.toString())),
      (_) {
        _appEventBus.fire(AppEvent.plantsUpdated);
        emit(state.copyWith(deleteRequestState: RequestState.success));
      },
    );
  }

  Future<void> refresh() async {
    await getPlantDetails();
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    return super.close();
  }
}

class PlantDetailsState extends Equatable {
  final RequestState plantDetailsRequestState;
  final RequestState stagesRequestState;
  final RequestState deleteRequestState;
  final String? errorMessage;
  final PlantModel? plant;
  final List<StageModel>? stages;
  final bool isAuthor;
  final bool isInUsedBy;

  const PlantDetailsState({
    required this.plantDetailsRequestState,
    required this.stagesRequestState,
    required this.deleteRequestState,
    this.errorMessage,
    this.plant,
    this.stages,
    this.isAuthor = false,
    this.isInUsedBy = false,
  });

  PlantDetailsState copyWith({
    RequestState? plantDetailsRequestState,
    RequestState? stagesRequestState,
    RequestState? deleteRequestState,
    String? errorMessage,
    PlantModel? plant,
    List<StageModel>? stages,
    bool? isAuthor,
    bool? isInUsedBy,
  }) {
    return PlantDetailsState(
      plantDetailsRequestState: plantDetailsRequestState ?? this.plantDetailsRequestState,
      stagesRequestState: stagesRequestState ?? this.stagesRequestState,
      deleteRequestState: deleteRequestState ?? this.deleteRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      plant: plant ?? this.plant,
      stages: stages ?? this.stages,
      isAuthor: isAuthor ?? this.isAuthor,
      isInUsedBy: isInUsedBy ?? this.isInUsedBy,
    );
  }

  factory PlantDetailsState.initial() {
    return const PlantDetailsState(
      plantDetailsRequestState: RequestState.initial,
      stagesRequestState: RequestState.initial,
      deleteRequestState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [
        plantDetailsRequestState,
        stagesRequestState,
        deleteRequestState,
        errorMessage,
        plant,
        stages,
        isAuthor,
        isInUsedBy,
      ];
}

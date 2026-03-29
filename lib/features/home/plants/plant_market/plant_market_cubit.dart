import 'dart:async';

import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_market_plants_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/state_management/base/request_state.dart';

class PlantMarketCubit extends Cubit<PlantMarketState> {
  final GetMarketPlantsUseCase _getMarketPlantsUseCase;
  final AddPlantToUserUseCase _addPlantToUserUseCase;
  final AppEventBus _appEventBus;
  late final StreamSubscription<AppEvent> _eventSubscription;

  PlantMarketCubit(this._getMarketPlantsUseCase, this._addPlantToUserUseCase, this._appEventBus)
      : super(PlantMarketState.initial()) {
    _eventSubscription = _appEventBus.stream.listen((event) {
      if (event == AppEvent.plantsUpdated) refresh();
    });
  }

  Future<List<PlantModel>> getMarketPlants([int page = 1, int size = 20]) async {
    emit(state.copyWith(plantMarketRequestState: RequestState.loading, page: page));
    final result = await _getMarketPlantsUseCase((page: state.page, size: size));
    emit(result.match(
      (failure) => state.copyWith(plantMarketRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(plantMarketRequestState: RequestState.success, plants: data),
    ));
    return state.plants;
  }

  Future<void> addPlantToUser(int plantId, String userId) async {
    emit(state.copyWith(addPlantRequestState: RequestState.loading));
    final result = await _addPlantToUserUseCase((plantId: plantId, userId: userId));
    emit(result.match(
      (failure) => state.copyWith(addPlantRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (_) => state.copyWith(addPlantRequestState: RequestState.success),
    ));
  }

  Future<void> refresh() async {
    emit(PlantMarketState.initial());
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    return super.close();
  }
}

class PlantMarketState extends Equatable {
  final List<PlantModel> plants;
  final RequestState plantMarketRequestState;
  final RequestState addPlantRequestState;
  final String? errorMessage;
  final int page;

  const PlantMarketState({
    required this.plants,
    required this.plantMarketRequestState,
    required this.addPlantRequestState,
    this.errorMessage,
    required this.page,
  });

  PlantMarketState copyWith({
    List<PlantModel>? plants,
    RequestState? plantMarketRequestState,
    RequestState? addPlantRequestState,
    String? errorMessage,
    int? page,
  }) {
    return PlantMarketState(
      plants: plants ?? this.plants,
      plantMarketRequestState: plantMarketRequestState ?? this.plantMarketRequestState,
      addPlantRequestState: addPlantRequestState ?? this.addPlantRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  factory PlantMarketState.initial() {
    return const PlantMarketState(
      plants: [],
      plantMarketRequestState: RequestState.initial,
      addPlantRequestState: RequestState.initial,
      page: 1,
    );
  }

  @override
  List<Object?> get props => [plants, plantMarketRequestState, addPlantRequestState, errorMessage, page];
}

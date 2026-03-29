import 'dart:async';

import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plants_created_by_me_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/state_management/base/request_state.dart';

class MyPlantsCubit extends Cubit<MyPlantsState> {
  final GetPlantsCreatedByMeUseCase _getPlantsCreatedByMeUseCase;
  final AppEventBus _appEventBus;
  final String userId;
  late final StreamSubscription<AppEvent> _eventSubscription;

  MyPlantsCubit(this._getPlantsCreatedByMeUseCase, this._appEventBus, {required this.userId})
      : super(MyPlantsState.initial()) {
    _eventSubscription = _appEventBus.stream.listen((event) {
      if (event == AppEvent.plantsUpdated) refresh();
    });
    getMyPlants();
  }

  Future<List<PlantModel>> getMyPlants([int page = 1, int size = 20]) async {
    emit(state.copyWith(myPlantsRequestState: RequestState.loading, page: page));
    final result = await _getPlantsCreatedByMeUseCase((id: userId, page: state.page, size: size));
    emit(result.match(
      (failure) => state.copyWith(myPlantsRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(myPlantsRequestState: RequestState.success, plants: data, page: page),
    ));
    return state.plants;
  }

  Future<void> refresh() async {
    emit(MyPlantsState.initial());
    getMyPlants();
  }

  @override
  Future<void> close() {
    _eventSubscription.cancel();
    return super.close();
  }
}

class MyPlantsState extends Equatable {
  final List<PlantModel> plants;
  final RequestState myPlantsRequestState;
  final String? errorMessage;
  final int page;

  const MyPlantsState({
    this.errorMessage,
    required this.plants,
    required this.myPlantsRequestState,
    required this.page,
  });

  MyPlantsState copyWith({
    List<PlantModel>? plants,
    RequestState? myPlantsRequestState,
    String? errorMessage,
    int? page,
  }) {
    return MyPlantsState(
      plants: plants ?? this.plants,
      myPlantsRequestState: myPlantsRequestState ?? this.myPlantsRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  factory MyPlantsState.initial() {
    return const MyPlantsState(
      plants: [],
      myPlantsRequestState: RequestState.initial,
      page: 1,
    );
  }

  @override
  List<Object?> get props => [plants, myPlantsRequestState, errorMessage, page];
}

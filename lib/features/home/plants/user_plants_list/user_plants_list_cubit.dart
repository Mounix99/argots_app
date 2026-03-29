import 'dart:async';

import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/usecases/plant_usecases/get_plants_created_by_me_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/get_user_plants_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/state_management/base/request_state.dart';

class MyPlantsCubit extends Cubit<MyPlantsState> {
  final GetPlantsCreatedByMeUseCase _getPlantsCreatedByMeUseCase;
  final GetUserPlantsUseCase _getUserPlantsUseCase;
  final AppEventBus _appEventBus;
  final String userId;
  late final StreamSubscription<AppEvent> _eventSubscription;

  MyPlantsCubit(
    this._getPlantsCreatedByMeUseCase,
    this._getUserPlantsUseCase,
    this._appEventBus, {
    required this.userId,
  }) : super(MyPlantsState.initial()) {
    _eventSubscription = _appEventBus.stream.listen((event) {
      if (event == AppEvent.plantsUpdated) refresh();
    });
  }

  Future<List<PlantModel>> getMyPlants([int page = 1, int size = 20]) async {
    emit(state.copyWith(myPlantsRequestState: RequestState.loading, page: page));

    final params = (id: userId, page: page, size: size);
    final results = await Future.wait([
      _getPlantsCreatedByMeUseCase(params),
      _getUserPlantsUseCase(params),
    ]);

    final createdResult = results[0];
    final usedResult = results[1];

    if (createdResult.isLeft() && usedResult.isLeft()) {
      final failure = createdResult.getLeft().toNullable()!;
      emit(state.copyWith(myPlantsRequestState: RequestState.error, errorMessage: failure.error.toString()));
      return state.plants;
    }

    final createdPlants = createdResult.getRight().toNullable() ?? [];
    final usedPlants = usedResult.getRight().toNullable() ?? [];

    final seenIds = <int>{};
    final merged = [
      ...createdPlants,
      ...usedPlants,
    ].where((plant) => seenIds.add(plant.id)).toList();

    emit(state.copyWith(myPlantsRequestState: RequestState.success, plants: merged, page: page));
    return state.plants;
  }

  Future<void> refresh() async {
    emit(MyPlantsState.initial());
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

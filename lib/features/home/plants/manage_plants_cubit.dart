import 'package:agrost_app/common/state_management/base/request_state.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_to_user_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/remove_plant_from_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagePlantsCubit extends Cubit<ManagePlantsState> {
  final AddPlantToUserUseCase _addPlantToUserUseCase;
  final RemovePlantFromUserUseCase _removePlantFromUserUseCase;
  final String userId;

  ManagePlantsCubit(this._addPlantToUserUseCase, this._removePlantFromUserUseCase, this.userId)
      : super(ManagePlantsState.initial());

  Future<void> addPlantToUser(int plantId) async {
    emit(state.copyWith(addPlantToUserRequestState: RequestState.loading));
    final result = await _addPlantToUserUseCase((plantId: plantId, userId: userId));
    emit(result.match(
      (failure) =>
          state.copyWith(addPlantToUserRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (_) => state.copyWith(addPlantToUserRequestState: RequestState.success),
    ));
  }

  Future<void> removePlantFromUser(int plantId) async {
    emit(state.copyWith(removePlantFromUserRequestState: RequestState.loading));
    final result = await _removePlantFromUserUseCase((plantId: plantId, userId: userId));
    emit(result.match(
      (failure) =>
          state.copyWith(removePlantFromUserRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (_) => state.copyWith(removePlantFromUserRequestState: RequestState.success),
    ));
  }

  Future<void> refresh() async {
    emit(ManagePlantsState.initial());
  }
}

class ManagePlantsState extends Equatable {
  final RequestState addPlantToUserRequestState;
  final RequestState removePlantFromUserRequestState;
  final String? errorMessage;

  const ManagePlantsState({
    required this.addPlantToUserRequestState,
    required this.removePlantFromUserRequestState,
    this.errorMessage,
  });

  ManagePlantsState copyWith({
    RequestState? addPlantToUserRequestState,
    RequestState? removePlantFromUserRequestState,
    String? errorMessage,
  }) {
    return ManagePlantsState(
      addPlantToUserRequestState: addPlantToUserRequestState ?? this.addPlantToUserRequestState,
      removePlantFromUserRequestState: removePlantFromUserRequestState ?? this.removePlantFromUserRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory ManagePlantsState.initial() {
    return const ManagePlantsState(
      addPlantToUserRequestState: RequestState.initial,
      removePlantFromUserRequestState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [addPlantToUserRequestState, removePlantFromUserRequestState, errorMessage];
}

import 'package:agrost_app/common/extensions/future_extensions.dart';
import 'package:agrost_app/common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagePlantsCubit extends Cubit<ManagePlantsState> {
  final PlantsRepository _plantsRepository;

  final String userId;

  ManagePlantsCubit(this._plantsRepository, this.userId) : super(ManagePlantsState.initial());

  void addPlantToUser(int plantId) {
    emit(state.copyWith(addPlantToUserRequestState: RequestState.loading));
    _plantsRepository.addPlantToUser(plantId: plantId, userId: userId).withProgress().then((value) {
      emit(value.fold(
        (failure) =>
            state.copyWith(addPlantToUserRequestState: RequestState.error, errorMessage: failure.error.toString()),
        (data) => state.copyWith(addPlantToUserRequestState: RequestState.success),
      ));
    });
  }

  void removePlantFromUser(int plantId) {
    emit(state.copyWith(removePlantFromUserRequestState: RequestState.loading));
    // _plantsRepository.removePlant(plantId: plantId).then((result) {
    //   emit(result.fold(
    //     (failure) => state.copyWith(removePlantFromUserRequestState: RequestState.error, errorMessage: failure.error.toString()),
    //     (data) => state.copyWith(removePlantFromUserRequestState: RequestState.success),
    //   ));
    // });
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
  List<Object?> get props => [addPlantToUserRequestState, removePlantFromUserRequestState];
}

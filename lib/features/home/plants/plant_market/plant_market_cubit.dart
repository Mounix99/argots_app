import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

class PlantMarketCubit extends Cubit<PlantMarketState> {
  final PlantsRepository _plantsRepository;

  PlantMarketCubit(this._plantsRepository) : super(PlantMarketState.initial()) {
    getMarketPlants();
  }

  Future<List<PlantModel>> getMarketPlants([int page = 1, int size = 20]) async {
    emit(state.copyWith(plantMarketRequestState: RequestState.loading, page: page));
    final result = await _plantsRepository.getMarketPlants(page: state.page, size: size);
    emit(result.fold(
      (failure) => state.copyWith(plantMarketRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(plantMarketRequestState: RequestState.success, plants: data),
    ));
    return state.plants;
  }

  void addPlantToUser(PlantModel plant, String id) {}

  Future<void> refresh() async {
    emit(PlantMarketState.initial());
    getMarketPlants();
  }
}

class PlantMarketState extends Equatable {
  final List<PlantModel> plants;
  final RequestState plantMarketRequestState;
  final String? errorMessage;
  final int page;

  const PlantMarketState({
    required this.plants,
    required this.plantMarketRequestState,
    this.errorMessage,
    required this.page,
  });

  PlantMarketState copyWith({
    List<PlantModel>? plants,
    RequestState? plantMarketRequestState,
    String? errorMessage,
    int? page,
  }) {
    return PlantMarketState(
      plants: plants ?? this.plants,
      plantMarketRequestState: plantMarketRequestState ?? this.plantMarketRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  factory PlantMarketState.initial() {
    return const PlantMarketState(
      plants: [],
      plantMarketRequestState: RequestState.initial,
      page: 1,
    );
  }

  @override
  List<Object?> get props => [plants, plantMarketRequestState, errorMessage, page];
}

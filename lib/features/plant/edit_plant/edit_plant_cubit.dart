import 'package:agrost_app/common/extensions/future_extensions.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

enum AddPlantFormFields { title, description, soilType, plantType, public }

class CreatePlantCubit extends Cubit<CreatePlantState> {
  final PlantsRepository _plantsRepository;
  final String userId;
  late final FormGroup form;

  CreatePlantCubit(this._plantsRepository, {required this.userId}) : super(CreatePlantState.initial()) {
    form = FormGroup({
      'title': FormControl<String>(validators: [Validators.required]),
      'description': FormControl<String?>(),
      'soilType': FormControl<Iterable<String>>(),
      'plantType': FormControl<Iterable<String>>(),
      'public': FormControl<bool>(validators: [Validators.required], value: true),
    });
  }

  void createPlant(PlantModel plant) {
    emit(state.copyWith(createPlantState: RequestState.loading));
    _plantsRepository.addPlant(plantData: plant.toJson()).withProgress().then((value) {
      emit(value.fold(
        (failure) => state.copyWith(createPlantState: RequestState.error, errorMessage: failure.error.toString()),
        (data) => state.copyWith(createPlantState: RequestState.success),
      ));
    });
  }
}

class CreatePlantState extends Equatable {
  final RequestState createPlantState;
  final String? errorMessage;
  final int? plantId;
  const CreatePlantState({required this.createPlantState, this.errorMessage, this.plantId});

  factory CreatePlantState.initial() {
    return const CreatePlantState(createPlantState: RequestState.initial);
  }

  CreatePlantState copyWith({
    RequestState? createPlantState,
    String? errorMessage,
    int? plantId,
  }) {
    return CreatePlantState(
      createPlantState: createPlantState ?? this.createPlantState,
      errorMessage: errorMessage ?? this.errorMessage,
      plantId: plantId ?? this.plantId,
    );
  }

  @override
  List<Object?> get props => [createPlantState, errorMessage, plantId];
}

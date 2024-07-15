import 'package:agrost_app/common/extensions/future_extensions.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/repositories/plant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';
import '../general_plant_values_and_options/soil_type.dart';

enum EditPlantFormFields { title, description, soilType, plantType, public, version, photoUrl }

class EditPlantCubit extends Cubit<EditPlantState> {
  final PlantsRepository _plantsRepository;
  final String userId;
  late final FormGroup form;

  EditPlantCubit.create(this._plantsRepository, {required this.userId}) : super(EditPlantState.initial()) {
    declareFormValues();
  }

  EditPlantCubit.edit(this._plantsRepository, {required this.userId, required int plantId})
      : super(EditPlantState.initial()) {
    declareFormValues();
    getPlantInfo(plantId).then((_) {
      declareFormValues(plantModel: state.existingPlantInfo);
    });
  }

  void declareFormValues({PlantModel? plantModel}) {
    form = FormGroup({
      EditPlantFormFields.title.name: FormControl<String>(validators: [Validators.required], value: plantModel?.title),
      EditPlantFormFields.description.name: FormControl<String?>(value: plantModel?.description),
      EditPlantFormFields.soilType.name:
          FormControl<Iterable<SoilType>>(value: plantModel?.soilType?.map((e) => SoilType.fromString(e))),
      EditPlantFormFields.plantType.name: FormControl<Iterable<String>>(value: plantModel?.plantType),
      EditPlantFormFields.public.name:
          FormControl<bool>(validators: [Validators.required], value: plantModel?.public ?? true),
      EditPlantFormFields.version.name:
          FormControl<String>(validators: [Validators.required], value: plantModel?.version),
      EditPlantFormFields.photoUrl.name: FormControl<String?>(value: plantModel?.photoUrl),
    });
  }

  Future<void> getPlantInfo(int plantId) async {
    emit(state.copyWith(createPlantState: RequestState.loading));
    await _plantsRepository.getPlantInfo(plantId: plantId).withProgress().then((value) {
      emit(value.fold(
        (failure) => state.copyWith(createPlantState: RequestState.error, errorMessage: failure.error.toString()),
        (data) => state.copyWith(createPlantState: RequestState.success, existingPlantInfo: data),
      ));
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

class EditPlantState extends Equatable {
  final RequestState createPlantState;
  final RequestState getPlantInfoState;
  final PlantModel? existingPlantInfo;
  final String? errorMessage;
  final int? plantId;
  const EditPlantState(
      {required this.createPlantState,
      this.errorMessage,
      this.plantId,
      required this.getPlantInfoState,
      required this.existingPlantInfo});

  factory EditPlantState.initial() {
    return const EditPlantState(
        createPlantState: RequestState.initial, getPlantInfoState: RequestState.initial, existingPlantInfo: null);
  }

  EditPlantState copyWith({
    RequestState? createPlantState,
    RequestState? getPlantInfoState,
    PlantModel? existingPlantInfo,
    String? errorMessage,
    int? plantId,
  }) {
    return EditPlantState(
      createPlantState: createPlantState ?? this.createPlantState,
      getPlantInfoState: getPlantInfoState ?? this.getPlantInfoState,
      existingPlantInfo: existingPlantInfo ?? this.existingPlantInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      plantId: plantId ?? this.plantId,
    );
  }

  @override
  List<Object?> get props => [createPlantState, getPlantInfoState, errorMessage, plantId, existingPlantInfo];
}

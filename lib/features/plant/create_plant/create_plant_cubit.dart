import 'package:agrost_app/common/state_management/base/request_state.dart';
import 'package:agrost_app/common/system_values/system_values_cache.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/system_values/entities/growth_season.dart';
import 'package:domain/system_values/entities/light_requirement.dart';
import 'package:domain/system_values/entities/plant_type.dart';
import 'package:domain/system_values/entities/soil_type.dart';
import 'package:domain/system_values/entities/watering_frequency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum CreatePlantFormFields { plantName, plantFamily, description, stageName, stageDescription, stageDuration }

enum StageTimeFormat { days, weeks }

class LocalStageData extends Equatable {
  final String name;
  final String? description;
  final int duration;
  final StageTimeFormat timeFormat;

  const LocalStageData({
    required this.name,
    this.description,
    required this.duration,
    required this.timeFormat,
  });

  int get durationInSeconds {
    switch (timeFormat) {
      case StageTimeFormat.days:
        return duration * Duration.secondsPerDay;
      case StageTimeFormat.weeks:
        return duration * Duration.secondsPerDay * 7;
    }
  }

  @override
  List<Object?> get props => [name, description, duration, timeFormat];
}

class CreatePlantState extends Equatable {
  final RequestState requestState;
  final String? errorMessage;
  final bool isPublic;
  final XFile? selectedPhoto;
  final List<LocalStageData> stages;
  final List<String> selectedSoilTypes;
  final List<String> selectedPlantTypes;
  final String? selectedLightRequirement;
  final String? selectedWateringFrequency;
  final List<String> selectedGrowthSeasons;

  // System value options
  final List<SoilType> soilTypeOptions;
  final List<PlantType> plantTypeOptions;
  final List<LightRequirement> lightRequirementOptions;
  final List<WateringFrequency> wateringFrequencyOptions;
  final List<GrowthSeason> growthSeasonOptions;
  final bool optionsLoaded;

  const CreatePlantState({
    this.requestState = RequestState.initial,
    this.errorMessage,
    this.isPublic = false,
    this.selectedPhoto,
    this.stages = const [],
    this.selectedSoilTypes = const [],
    this.selectedPlantTypes = const [],
    this.selectedLightRequirement,
    this.selectedWateringFrequency,
    this.selectedGrowthSeasons = const [],
    this.soilTypeOptions = const [],
    this.plantTypeOptions = const [],
    this.lightRequirementOptions = const [],
    this.wateringFrequencyOptions = const [],
    this.growthSeasonOptions = const [],
    this.optionsLoaded = false,
  });

  CreatePlantState copyWith({
    RequestState? requestState,
    String? errorMessage,
    bool? isPublic,
    XFile? selectedPhoto,
    bool clearPhoto = false,
    List<LocalStageData>? stages,
    List<String>? selectedSoilTypes,
    List<String>? selectedPlantTypes,
    String? selectedLightRequirement,
    bool clearLightRequirement = false,
    String? selectedWateringFrequency,
    bool clearWateringFrequency = false,
    List<String>? selectedGrowthSeasons,
    List<SoilType>? soilTypeOptions,
    List<PlantType>? plantTypeOptions,
    List<LightRequirement>? lightRequirementOptions,
    List<WateringFrequency>? wateringFrequencyOptions,
    List<GrowthSeason>? growthSeasonOptions,
    bool? optionsLoaded,
  }) {
    return CreatePlantState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      isPublic: isPublic ?? this.isPublic,
      selectedPhoto: clearPhoto ? null : (selectedPhoto ?? this.selectedPhoto),
      stages: stages ?? this.stages,
      selectedSoilTypes: selectedSoilTypes ?? this.selectedSoilTypes,
      selectedPlantTypes: selectedPlantTypes ?? this.selectedPlantTypes,
      selectedLightRequirement: clearLightRequirement ? null : (selectedLightRequirement ?? this.selectedLightRequirement),
      selectedWateringFrequency: clearWateringFrequency ? null : (selectedWateringFrequency ?? this.selectedWateringFrequency),
      selectedGrowthSeasons: selectedGrowthSeasons ?? this.selectedGrowthSeasons,
      soilTypeOptions: soilTypeOptions ?? this.soilTypeOptions,
      plantTypeOptions: plantTypeOptions ?? this.plantTypeOptions,
      lightRequirementOptions: lightRequirementOptions ?? this.lightRequirementOptions,
      wateringFrequencyOptions: wateringFrequencyOptions ?? this.wateringFrequencyOptions,
      growthSeasonOptions: growthSeasonOptions ?? this.growthSeasonOptions,
      optionsLoaded: optionsLoaded ?? this.optionsLoaded,
    );
  }

  @override
  List<Object?> get props => [
        requestState,
        errorMessage,
        isPublic,
        selectedPhoto,
        stages,
        selectedSoilTypes,
        selectedPlantTypes,
        selectedLightRequirement,
        selectedWateringFrequency,
        selectedGrowthSeasons,
        soilTypeOptions,
        plantTypeOptions,
        lightRequirementOptions,
        wateringFrequencyOptions,
        growthSeasonOptions,
        optionsLoaded,
      ];
}

class CreatePlantCubit extends Cubit<CreatePlantState> {
  CreatePlantCubit({
    required AddPlantUseCase addPlantUseCase,
    required AddStageUseCase addStageUseCase,
    required SystemValuesCache systemValuesCache,
    required String authorId,
  })  : _addPlantUseCase = addPlantUseCase,
        _addStageUseCase = addStageUseCase,
        _systemValuesCache = systemValuesCache,
        _authorId = authorId,
        super(const CreatePlantState()) {
    _initForm();
    _loadOptions();
  }

  final AddPlantUseCase _addPlantUseCase;
  final AddStageUseCase _addStageUseCase;
  final SystemValuesCache _systemValuesCache;
  final String _authorId;
  final _imagePicker = ImagePicker();

  late final FormGroup plantForm;
  late final FormGroup stageForm;

  void _initForm() {
    plantForm = FormGroup({
      CreatePlantFormFields.plantName.name: FormControl<String>(validators: [Validators.required]),
      CreatePlantFormFields.plantFamily.name: FormControl<String>(),
      CreatePlantFormFields.description.name: FormControl<String>(),
    });

    stageForm = FormGroup({
      CreatePlantFormFields.stageName.name: FormControl<String>(validators: [Validators.required]),
      CreatePlantFormFields.stageDescription.name: FormControl<String>(),
      CreatePlantFormFields.stageDuration.name: FormControl<int>(validators: [Validators.required, Validators.min(1)]),
    });
  }

  Future<void> _loadOptions() async {
    final results = await Future.wait([
      _systemValuesCache.getSoilTypes(),
      _systemValuesCache.getPlantTypes(),
      _systemValuesCache.getLightRequirements(),
      _systemValuesCache.getWateringFrequencies(),
      _systemValuesCache.getGrowthSeasons(),
    ]);

    emit(state.copyWith(
      soilTypeOptions: results[0] as List<SoilType>,
      plantTypeOptions: results[1] as List<PlantType>,
      lightRequirementOptions: results[2] as List<LightRequirement>,
      wateringFrequencyOptions: results[3] as List<WateringFrequency>,
      growthSeasonOptions: results[4] as List<GrowthSeason>,
      optionsLoaded: true,
    ));
  }

  Future<void> pickPhoto(ImageSource source) async {
    final file = await _imagePicker.pickImage(source: source, imageQuality: 85);
    if (file != null) {
      emit(state.copyWith(selectedPhoto: file));
    }
  }

  void togglePublic() => emit(state.copyWith(isPublic: !state.isPublic));

  void toggleSoilType(String value) {
    final updated = List<String>.from(state.selectedSoilTypes);
    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }
    emit(state.copyWith(selectedSoilTypes: updated));
  }

  void togglePlantType(String value) {
    final updated = List<String>.from(state.selectedPlantTypes);
    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }
    emit(state.copyWith(selectedPlantTypes: updated));
  }

  void selectLightRequirement(String? value) => emit(state.copyWith(
        selectedLightRequirement: value,
        clearLightRequirement: value == null,
      ));

  void selectWateringFrequency(String? value) => emit(state.copyWith(
        selectedWateringFrequency: value,
        clearWateringFrequency: value == null,
      ));

  void toggleGrowthSeason(String value) {
    final updated = List<String>.from(state.selectedGrowthSeasons);
    if (updated.contains(value)) {
      updated.remove(value);
    } else {
      updated.add(value);
    }
    emit(state.copyWith(selectedGrowthSeasons: updated));
  }

  void addStage(StageTimeFormat timeFormat) {
    if (!stageForm.valid) {
      stageForm.markAllAsTouched();
      return;
    }
    final name = stageForm.control(CreatePlantFormFields.stageName.name).value as String;
    final description = stageForm.control(CreatePlantFormFields.stageDescription.name).value as String?;
    final duration = stageForm.control(CreatePlantFormFields.stageDuration.name).value as int;

    final stage = LocalStageData(
      name: name,
      description: description?.isEmpty == true ? null : description,
      duration: duration,
      timeFormat: timeFormat,
    );

    emit(state.copyWith(stages: [...state.stages, stage]));
    stageForm.reset();
  }

  void removeStage(int index) {
    final updated = List<LocalStageData>.from(state.stages)..removeAt(index);
    emit(state.copyWith(stages: updated));
  }

  Future<void> createPlant() async {
    if (!plantForm.valid) {
      plantForm.markAllAsTouched();
      return;
    }

    emit(state.copyWith(requestState: RequestState.loading));

    final name = plantForm.control(CreatePlantFormFields.plantName.name).value as String;
    final family = plantForm.control(CreatePlantFormFields.plantFamily.name).value as String?;
    final description = plantForm.control(CreatePlantFormFields.description.name).value as String?;

    final plantModel = PlantModel(
      id: 0,
      title: name,
      description: description?.isEmpty == true ? null : description,
      authorId: _authorId,
      soilType: state.selectedSoilTypes.isEmpty ? null : state.selectedSoilTypes,
      plantType: state.selectedPlantTypes.isEmpty ? null : (family != null && family.isNotEmpty ? [family] : state.selectedPlantTypes),
      public: state.isPublic,
      createdAt: DateTime.now(),
      version: '1.0',
      photoUrl: null,
      lightRequirements: state.selectedLightRequirement,
      wateringFrequency: state.selectedWateringFrequency,
      growthSeasons: state.selectedGrowthSeasons.isEmpty ? null : state.selectedGrowthSeasons,
    );

    final plantResult = await _addPlantUseCase(plantModel);

    await plantResult.fold(
      (failure) async {
        emit(state.copyWith(requestState: RequestState.error, errorMessage: failure.error.toString()));
      },
      (createdPlant) async {
        for (final localStage in state.stages) {
          final stageModel = StageModel(
            id: 0,
            title: localStage.name,
            description: localStage.description,
            createdAt: DateTime.now(),
            lastUpdateAt: DateTime.now(),
            plantId: createdPlant.id,
            authorId: _authorId,
            duration: localStage.durationInSeconds,
          );
          await _addStageUseCase(stageModel);
        }
        emit(state.copyWith(requestState: RequestState.success));
      },
    );
  }
}

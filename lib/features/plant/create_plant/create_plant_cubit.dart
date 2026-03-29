import 'package:agrost_app/common/app_event_bus/app_event_bus.dart';
import 'package:agrost_app/common/state_management/base/request_state.dart';
import 'package:agrost_app/common/system_values/system_values_cache.dart';
import 'package:domain/plants/entities/plant_model.dart';
import 'package:domain/plants/entities/stage_model.dart';
import 'package:domain/plants/usecases/plant_usecases/add_plant_usecase.dart';
import 'package:domain/plants/usecases/plant_usecases/update_plant_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/add_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/delete_stage_usecase.dart';
import 'package:domain/plants/usecases/stage_usecases/get_list_of_stages_usecase.dart';
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

enum StageTimeFormat { days, weeks, months, years }

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
      case StageTimeFormat.months:
        return duration * Duration.secondsPerDay * 30;
      case StageTimeFormat.years:
        return duration * Duration.secondsPerDay * 365;
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

  final List<SoilType> soilTypeOptions;
  final List<PlantType> plantTypeOptions;
  final List<LightRequirement> lightRequirementOptions;
  final List<WateringFrequency> wateringFrequencyOptions;
  final List<GrowthSeason> growthSeasonOptions;
  final bool optionsLoaded;

  final bool isEditMode;
  final String? existingPhotoUrl;

  final List<StageModel> existingStages;
  final RequestState existingStagesRequestState;

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
    this.isEditMode = false,
    this.existingPhotoUrl,
    this.existingStages = const [],
    this.existingStagesRequestState = RequestState.initial,
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
    bool? isEditMode,
    String? existingPhotoUrl,
    List<StageModel>? existingStages,
    RequestState? existingStagesRequestState,
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
      isEditMode: isEditMode ?? this.isEditMode,
      existingPhotoUrl: existingPhotoUrl ?? this.existingPhotoUrl,
      existingStages: existingStages ?? this.existingStages,
      existingStagesRequestState: existingStagesRequestState ?? this.existingStagesRequestState,
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
        isEditMode,
        existingPhotoUrl,
        existingStages,
        existingStagesRequestState,
      ];
}

class CreatePlantCubit extends Cubit<CreatePlantState> {
  CreatePlantCubit({
    required AddPlantUseCase addPlantUseCase,
    required AddStageUseCase addStageUseCase,
    required SystemValuesCache systemValuesCache,
    required AppEventBus appEventBus,
    required String authorId,
    this.existingPlant,
    UpdatePlantUseCase? updatePlantUseCase,
    GetListOfStagesUseCase? getListOfStagesUseCase,
    DeleteStageUseCase? deleteStageUseCase,
  })  : _addPlantUseCase = addPlantUseCase,
        _addStageUseCase = addStageUseCase,
        _updatePlantUseCase = updatePlantUseCase,
        _getListOfStagesUseCase = getListOfStagesUseCase,
        _deleteStageUseCase = deleteStageUseCase,
        _systemValuesCache = systemValuesCache,
        _appEventBus = appEventBus,
        _authorId = authorId,
        super(const CreatePlantState()) {
    _initForm();
    _loadOptions();
    if (existingPlant != null) {
      _prefillFromPlant(existingPlant!);
      _loadExistingStages();
    }
  }

  final AddPlantUseCase _addPlantUseCase;
  final AddStageUseCase _addStageUseCase;
  final UpdatePlantUseCase? _updatePlantUseCase;
  final GetListOfStagesUseCase? _getListOfStagesUseCase;
  final DeleteStageUseCase? _deleteStageUseCase;
  final SystemValuesCache _systemValuesCache;
  final AppEventBus _appEventBus;
  final String _authorId;
  final PlantModel? existingPlant;
  final _imagePicker = ImagePicker();

  bool get isEditMode => existingPlant != null;

  late final FormGroup plantForm;
  late final FormGroup stageForm;

  void _initForm() {
    plantForm = FormGroup({
      CreatePlantFormFields.plantName.name: FormControl<String>(
        validators: [Validators.required],
        value: existingPlant?.title,
      ),
      CreatePlantFormFields.plantFamily.name: FormControl<String>(),
      CreatePlantFormFields.description.name: FormControl<String>(
        value: existingPlant?.description,
      ),
    });

    stageForm = FormGroup({
      CreatePlantFormFields.stageName.name: FormControl<String>(validators: [Validators.required]),
      CreatePlantFormFields.stageDescription.name: FormControl<String>(),
      CreatePlantFormFields.stageDuration.name: FormControl<int>(validators: [Validators.required, Validators.min(1)]),
    });
  }

  void _prefillFromPlant(PlantModel plant) {
    emit(state.copyWith(
      isEditMode: true,
      isPublic: plant.public,
      selectedSoilTypes: plant.soilType ?? [],
      selectedPlantTypes: plant.plantType ?? [],
      selectedLightRequirement: plant.lightRequirements,
      selectedWateringFrequency: plant.wateringFrequency,
      selectedGrowthSeasons: plant.growthSeasons ?? [],
      existingPhotoUrl: plant.photoUrl,
    ));
  }

  Future<void> _loadExistingStages() async {
    if (_getListOfStagesUseCase == null || existingPlant == null) return;
    emit(state.copyWith(existingStagesRequestState: RequestState.loading));
    final result = await _getListOfStagesUseCase((plantId: existingPlant!.id, page: 1, size: 50));
    emit(result.match(
      (failure) => state.copyWith(existingStagesRequestState: RequestState.error, errorMessage: failure.error.toString()),
      (data) => state.copyWith(existingStagesRequestState: RequestState.success, existingStages: data),
    ));
  }

  Future<void> deleteExistingStage(int stageId) async {
    if (_deleteStageUseCase == null) return;
    final result = await _deleteStageUseCase(stageId);
    result.match(
      (failure) => emit(state.copyWith(errorMessage: failure.error.toString())),
      (_) {
        final updated = state.existingStages.where((s) => s.id != stageId).toList();
        emit(state.copyWith(existingStages: updated));
      },
    );
  }

  Future<void> addStageToExistingPlant(StageTimeFormat timeFormat) async {
    if (!stageForm.valid) {
      stageForm.markAllAsTouched();
      return;
    }
    if (existingPlant == null) return;

    final name = stageForm.control(CreatePlantFormFields.stageName.name).value as String;
    final description = stageForm.control(CreatePlantFormFields.stageDescription.name).value as String?;
    final duration = stageForm.control(CreatePlantFormFields.stageDuration.name).value as int;

    final durationInSeconds = _computeDurationInSeconds(duration, timeFormat);

    final stageModel = StageModel(
      id: 0,
      title: name,
      description: description?.isEmpty == true ? null : description,
      createdAt: DateTime.now(),
      lastUpdateAt: DateTime.now(),
      plantId: existingPlant!.id,
      authorId: _authorId,
      duration: durationInSeconds,
    );

    final result = await _addStageUseCase(stageModel);
    result.match(
      (failure) => emit(state.copyWith(errorMessage: failure.error.toString())),
      (_) => stageForm.reset(),
    );
    if (result.isRight()) {
      await _loadExistingStages();
    }
  }

  int _computeDurationInSeconds(int duration, StageTimeFormat timeFormat) {
    switch (timeFormat) {
      case StageTimeFormat.days:
        return duration * Duration.secondsPerDay;
      case StageTimeFormat.weeks:
        return duration * Duration.secondsPerDay * 7;
      case StageTimeFormat.months:
        return duration * Duration.secondsPerDay * 30;
      case StageTimeFormat.years:
        return duration * Duration.secondsPerDay * 365;
    }
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
    try {
      final file = await _imagePicker.pickImage(source: source, imageQuality: 85);
      if (file != null) {
        emit(state.copyWith(selectedPhoto: file));
      }
    } catch (_) {
      // Permission denied or camera unavailable
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

  Future<void> savePlant() async {
    if (isEditMode) {
      await _updatePlant();
    } else {
      await _createPlant();
    }
  }

  Future<void> _createPlant() async {
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
        _appEventBus.fire(AppEvent.plantsUpdated);
        emit(state.copyWith(requestState: RequestState.success));
      },
    );
  }

  Future<void> _updatePlant() async {
    if (!plantForm.valid) {
      plantForm.markAllAsTouched();
      return;
    }
    if (_updatePlantUseCase == null) return;

    emit(state.copyWith(requestState: RequestState.loading));

    final name = plantForm.control(CreatePlantFormFields.plantName.name).value as String;
    final description = plantForm.control(CreatePlantFormFields.description.name).value as String?;

    final updatedPlant = existingPlant!.copyWith(
      title: name,
      description: description?.isEmpty == true ? null : description,
      soilType: state.selectedSoilTypes.isEmpty ? null : state.selectedSoilTypes,
      plantType: state.selectedPlantTypes.isEmpty ? null : state.selectedPlantTypes,
      public: state.isPublic,
      lightRequirements: state.selectedLightRequirement,
      wateringFrequency: state.selectedWateringFrequency,
      growthSeasons: state.selectedGrowthSeasons.isEmpty ? null : state.selectedGrowthSeasons,
      lastUpdateAt: DateTime.now(),
    );

    final result = await _updatePlantUseCase(updatedPlant);
    result.match(
      (failure) => emit(state.copyWith(requestState: RequestState.error, errorMessage: failure.error.toString())),
      (_) {
        _appEventBus.fire(AppEvent.plantsUpdated);
        emit(state.copyWith(requestState: RequestState.success));
      },
    );
  }

  @Deprecated('Use savePlant() instead')
  Future<void> createPlant() => savePlant();
}
